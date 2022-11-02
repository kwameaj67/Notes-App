//
//  NotesVC.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 09/10/2022.
//

import UIKit
import BottomSheet
import Combine

class NotesVC: UIViewController {
    
    private var cancellables: AnyCancellable?
    
    let childVC = BottomSheetVC()
    let noteDetailVC = NoteDetailsVC()
    let viewModel = FolderViewModel()
    let noteViewModel = NoteViewModel()
    private var notes:[Note] = [] {
        didSet{
            DispatchQueue.main.async {
                self.notesCollectionView.reloadData()
                self.toggleViews()
            }
        }
    }

    var folder: Folder! {
        didSet{
            self.navigationController?.navigationBar.largeContentTitle = folder?.heading
            title = folder?.heading
        }
    }
    var notesIndexPath: IndexPath = IndexPath(row: 0, section: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.bg
        setupViews()
        setupContraints()
        configureBackButton()
        toggleViews()
        getNotes()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }
    // MARK: Properties -
    let emptyLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.isHidden = true
        lb.alpha = 0
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let addButton: UIButton = {
        var btn = UIButton()
        btn.titleLabel?.font = UIFont(name: Font.semi_bold.rawValue, size: 16)
        btn.setTitle("Create note 📝", for: .normal)
        btn.titleLabel?.textColor = .white
        btn.layer.cornerRadius = 45/2
        btn.backgroundColor = Color.red
        btn.addTarget(self, action: #selector(createNewNote), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    lazy var notesCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        cv.register(NoteCollectionCell.self, forCellWithReuseIdentifier: NoteCollectionCell.reusableId)
        cv.delegate = self
        cv.dataSource = self
        cv.isScrollEnabled = true
        cv.bounces = true
        cv.isHidden = true
        cv.alpha = 0
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    func getNotes(){
        viewModel.getNotes(folder: folder)
        cancellables = viewModel.$notes.sink(receiveValue: { notes in
            self.notes = notes
            self.notes.reverse()
        })
    }
    @objc func createNewNote(){
        noteDetailVC.delegate = self
        noteDetailVC.folder = folder
        noteDetailVC.note = nil
        navigationController?.pushViewController(noteDetailVC, animated: true)
    }
    @objc func didTapNoteCell(note: Note){
        noteDetailVC.delegate = self
        noteDetailVC.folder = folder
        noteDetailVC.note = note
        navigationController?.pushViewController(noteDetailVC, animated: true)
    }
     func didTapEditOption(note: Note){
        noteDetailVC.delegate = self
        noteDetailVC.folder = folder
        noteDetailVC.note = note
        navigationController?.pushViewController(noteDetailVC, animated: true)
    }
    func toggleViews(){
        if notes.count > 0 {
            notesCollectionView.isHidden = false
            notesCollectionView.alpha = 1
            
            emptyLabel.isHidden = true
            emptyLabel.alpha = 0
        }
        else {
            emptyLabel.isHidden = false
            emptyLabel.alpha = 1
        }
    }
    @objc func didTapMoreImage(_ sender: UIButton){
        childVC.preferredContentSize  = CGSize(width: Int(view.frame.width), height: 180)
        childVC.delegate = self
        presentBottomSheet(
            viewController: childVC,
            configuration:  BottomSheetConfiguration(
                cornerRadius: 30,
                pullBarConfiguration: .visible(.init(height: 20)),
                shadowConfiguration: .init(backgroundColor: UIColor.black.withAlphaComponent(0.6))
            ))
    }
    func setupViews(){
        view.addSubview(notesCollectionView)
        view.addSubview(emptyLabel)
        view.addSubview(addButton)
        configureCompositionalLayout()
        emptyLabel.attributedText = setupAttributedText("Wow, such empty 😬", "You have not created any note ")
    }
   
    func setupContraints(){
        NSLayoutConstraint.activate([
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            notesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            notesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 4),
            notesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -4),
            notesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 45),
            addButton.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
}

extension NotesVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCollectionCell.reusableId, for: indexPath) as! NoteCollectionCell
        cell.data = notes[indexPath.row]
        cell.delegate = self
        cell.controller = self
        cell.bodyLabel.setLineHeight(lineHeight: 1.4)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let noteObject = notes[indexPath.row]
        didTapNoteCell(note: noteObject)
    }
}
extension NotesVC : NoteCellDelegate, BottomSheetItemDelegate  {
    func getCellPressed(in cell: UICollectionViewCell) {
        guard let indexPath = notesCollectionView.indexPath(for: cell) else { return }
        self.notesIndexPath = IndexPath(row: indexPath.row, section: 0)
    }
    
    func deleteItem() {
        // get note object to delete
        let item = notesIndexPath
        let noteObject  = self.notes[item.row]
        // delete object
        noteViewModel.deleteNote(note: noteObject)
        // remove note from row & tableview
        notes.remove(at:  item.row)
        notesCollectionView.deleteItems(at: [notesIndexPath])
        DispatchQueue.main.async {
            self.notesCollectionView.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func editItem() {
        dismiss(animated: true, completion: nil)
        let item = notesIndexPath
        let noteObject  = self.notes[item.row]
        didTapEditOption(note: noteObject)
    }
    
}

extension NotesVC: SaveNoteDelegate{
    func saveNote(isSaved: Bool) {
        if isSaved{
            getNotes()
        }
    }
}

extension NotesVC {
    func configureCompositionalLayout(){

        let groupOneLeftItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2)))
        groupOneLeftItem.contentInsets = .init(top: 8, leading: 6, bottom: 6, trailing: 6)
        
        let groupOneRightItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
        groupOneRightItem.contentInsets = .init(top: 8, leading: 6, bottom: 0, trailing: 6)
        
        let innerLeftGroupOne = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)), subitems: [groupOneLeftItem])
        
        let groupOne = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(400)), subitems: [innerLeftGroupOne,groupOneRightItem])
        
        let groupTwo = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)))
        groupTwo.contentInsets = .init(top: 8, leading: 6, bottom: 0, trailing: 6)
        
        let groupThreeItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
        groupThreeItem.contentInsets = .init(top: 8, leading: 6, bottom: 0, trailing: 6)
        
        let groupThree = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [groupThreeItem])
        
        let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(800)), subitems: [groupOne,groupTwo,groupThree])
        
        let section = NSCollectionLayoutSection.init(group: containerGroup)
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.contentInsetsReference = .none
    
        let layout = UICollectionViewCompositionalLayout(section: section)
        notesCollectionView.setCollectionViewLayout(layout, animated: true)
      
    }
    func configureNavBar(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font.semi_bold.rawValue, size: 15.0)!,NSAttributedString.Key.foregroundColor: Color.dark]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font.bold.rawValue, size: 22.0)!,NSAttributedString.Key.foregroundColor: Color.dark]
        self.navigationController?.navigationBar.prefersLargeTitles = true
             
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func configureBackButton(){
        let backImage =  UIImage(systemName: "arrow.left",withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .medium))
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: .none, action: .none)
        navigationController?.navigationBar.tintColor = Color.dark
    }
    func setupAttributedText(_ title: String,_ subTitle: String) -> NSAttributedString{
        let text = NSMutableAttributedString(string: title, attributes: [.foregroundColor: Color.dark,.font: UIFont(name: Font.semi_bold.rawValue, size: 18)!])
        text.append(NSAttributedString(string: "\n\n\(subTitle)", attributes: [.foregroundColor: Color.dark.withAlphaComponent(0.8),.font: UIFont(name: Font.medium.rawValue, size: 16)!]))
        return text
    }
}

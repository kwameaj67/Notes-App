//
//  ViewController.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 09/10/2022.
//

import UIKit
import Combine
import BottomSheet

class FolderVC: UIViewController {
   
    private var cancellables: AnyCancellable?
    let childVC = FolderOptionsVC()
    var folderIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    private var folders:[Folder] = [] {
        didSet{
            DispatchQueue.main.async {
                self.folderTableView.reloadData()
            }
            if folders.count > 0 {
                folderTableView.isHidden = false
                folderTableView.alpha = 1
            }
            else {
                emptyLabel.isHidden = false
                emptyLabel.alpha = 1
            }
        }
    }
    private let viewModel = FolderViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "folders"
        view.backgroundColor = Color.dark
        setupViews()
        setupContraints()
        getFolderData()
        configureBackButton()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
        title = "folders"
        navigationController?.navigationBar.isHidden = false
        folderTableView.reloadData()
    }
    func getFolderData(){
        viewModel.getFolders()
        cancellables = viewModel.$folders.sink { data in
            self.folders = data
            self.folders.reverse()
            print(self.folders.count)
        }
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
        var btn = AddFloatingButton()
        btn.addTarget(self, action: #selector(presentCreateFolderVC), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    lazy var folderTableView: UITableView = {
        let tv = UITableView(frame: .zero,style: .plain)
        tv.register(FolderCell.self, forCellReuseIdentifier: FolderCell.reusableId)
        tv.delegate = self
        tv.dataSource = self
        tv.tableHeaderView = UIView()
        tv.tableFooterView = UIView()
        tv.bounces = true
        tv.backgroundColor = Color.dark
        tv.separatorInset = UIEdgeInsets.zero
        tv.isHidden = true
        tv.alpha = 0
        tv.separatorColor = .clear
        tv.allowsSelection = true
        tv.allowsMultipleSelection = false
        tv.showsVerticalScrollIndicator = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    func setupViews(){
        view.addSubview(folderTableView)
        view.addSubview(addButton)
        view.addSubview(emptyLabel)
        addButton.bringSubviewToFront(folderTableView)
        
        emptyLabel.attributedText = setupAttributedText("Wow, such empty 😬", "You have no folders created")
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            folderTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            folderTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            folderTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            folderTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 90),
            addButton.widthAnchor.constraint(equalToConstant: 90),
        ])
    }
    
    @objc func presentCreateFolderVC(){
        let vc = AddFolderVC()
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    @objc func presentEditFolderVC(folder: Folder){
        let vc = EditFolderVC()
        vc.delegate = self
        vc.folder = folder
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
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
}

extension FolderVC:UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = view.backgroundColor
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let folder = folders[indexPath.row]
        let vc = NotesVC()
        print(folder.heading!)
        vc.folderTitle = folder.heading ?? "No title"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215.0
    }
    
}

extension FolderVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folders.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FolderCell.reusableId, for: indexPath) as! FolderCell
        cell.data = folders[indexPath.row]
        cell.delegate = self
        cell.controller = self
        cell.selectionStyle = .none
        return cell
    }
}

extension FolderVC {
    func configureNavBar(){

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font.bold.rawValue, size: 20.0)!,NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font.bold.rawValue, size: 28.0)!,NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.largeContentTitle = "folders"
        
        
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
        let text = NSMutableAttributedString(string: title, attributes: [.foregroundColor: UIColor.systemGray2,.font: UIFont(name: Font.semi_bold.rawValue, size: 18)!])
        text.append(NSAttributedString(string: "\n\n\(subTitle)", attributes: [.foregroundColor: UIColor.systemGray2.withAlphaComponent(0.8),.font: UIFont(name: Font.medium.rawValue, size: 16)!]))
        return text
    }
}

extension FolderVC: DeleteFolderDelegate, OptionCellDelegate {
    func getCellPressed(in cell: UITableViewCell) {
        guard let indexPath = folderTableView.indexPath(for: cell) else {
               return
           }
        self.folderIndexPath = IndexPath(row: indexPath.row, section: 0)
    }
    
    
    func deleteFolderItem() {
        // get folder object to delete
        let item = folderIndexPath
        let folderObject  = self.folders[item.row]
        // delete object
        viewModel.deleteFolder(folder: folderObject)
        // remove folder from row & tableview
        folders.remove(at:  item.row)
        folderTableView.deleteRows(at: [folderIndexPath], with: .fade)
        DispatchQueue.main.async {
            self.folderTableView.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }
    func editFolderItem() {
        dismiss(animated: true, completion: nil)
        let item = folderIndexPath
        let folderObject  = self.folders[item.row]
        presentEditFolderVC(folder: folderObject)
    }
}

extension FolderVC: SaveFolderDelegate, UpdateFolderDelegate {
   
    func saveFolder(isSaved: Bool) {
        if isSaved{
            getFolderData()
        }
    }
    
    func updatedFolder(isSaved: Bool) {
        if isSaved{
            getFolderData()
        }
    }
    
}

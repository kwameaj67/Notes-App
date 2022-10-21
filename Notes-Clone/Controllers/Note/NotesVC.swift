//
//  NotesVC.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 09/10/2022.
//

import UIKit

class NotesVC: UIViewController {
    let notesData = NoteType.data
    var notes : Note!
    var folderTitle: String? = "" {
        didSet{
            self.navigationController?.navigationBar.largeContentTitle = folderTitle
            title = folderTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.bg
        setupViews()
        setupContraints()
        configureBackButton()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
       
    }
    // MARK: Properties -
    let addButton: UIButton = {
        var btn = AddFloatingButton()
        btn.addTarget(self, action: #selector(createNote), for: .touchUpInside)
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
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    @objc func createNote(){
        let vc = NoteDetailsVC()
//        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    func setupViews(){
        view.addSubview(notesCollectionView)
        view.addSubview(addButton)
        configureCompositionalLayout()
    }
   
    func setupContraints(){
        NSLayoutConstraint.activate([
            notesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            notesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 4),
            notesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -4),
            notesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 90),
            addButton.widthAnchor.constraint(equalToConstant: 90),
        ])
    }
    func configureCompositionalLayout(){

        let groupOneRightItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2)))
        groupOneRightItem.contentInsets = .init(top: 8, leading: 6, bottom: 0, trailing: 6)
        
        let groupOneLeftItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
        groupOneLeftItem.contentInsets = .init(top: 8, leading: 6, bottom: 0, trailing: 6)
        
        let innerLeftGroupOne = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)), subitems: [groupOneRightItem])
        
        let groupOne = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(400)), subitems: [innerLeftGroupOne,groupOneLeftItem])
        
        let groupTwo = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)))
        groupTwo.contentInsets = .init(top: 8, leading: 6, bottom: 0, trailing: 6)
        
        let groupThreeItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
        groupThreeItem.contentInsets = .init(top: 8, leading: 6, bottom: 0, trailing: 6)
        
        let groupThree = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2)), subitems: [groupThreeItem])
        
        let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(600)), subitems: [groupOne,groupTwo,groupThree])
        
        let section = NSCollectionLayoutSection.init(group: containerGroup)
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.contentInsetsReference = .none
    
        let layout = UICollectionViewCompositionalLayout(section: section)
        notesCollectionView.setCollectionViewLayout(layout, animated: true)
      
    }
}

extension NotesVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCollectionCell.reusableId, for: indexPath) as! NoteCollectionCell
        cell.data = notesData[indexPath.row]
        cell.bodyLabel.setLineHeight(lineHeight: 1.4)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = notesData[indexPath.row]
        print(item.heading)
    }
    
    
}

extension NotesVC {
    func configureNavBar(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font.semi_bold.rawValue, size: 16.0)!,NSAttributedString.Key.foregroundColor: Color.dark]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font.bold.rawValue, size: 28.0)!,NSAttributedString.Key.foregroundColor: Color.dark]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
             
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        let searchBtn = UIButton(type: .system)
        let image = UIImage(named: "search")?.withRenderingMode(.alwaysTemplate).withConfiguration(UIImage.SymbolConfiguration(weight: .medium))
        searchBtn.setImage(image, for: .normal)
        searchBtn.tintColor = Color.dark
        searchBtn.adjustsImageWhenHighlighted = false
        searchBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
        searchBtn.backgroundColor = .clear
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBtn)
        
        let rightBarItem = UIBarButtonItem()
        rightBarItem.customView = searchBtn
        navigationItem.setRightBarButtonItems([rightBarItem], animated: true)
    }
    
    func configureBackButton(){
        let backImage =  UIImage(systemName: "arrow.left",withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .medium))
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: .none, action: .none)
        navigationController?.navigationBar.tintColor = Color.dark
    }
}

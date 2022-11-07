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
   
    let userDefaultManager = UserDefaultsManager.shared
    private var cancellables: AnyCancellable?
    let childVC = BottomSheetVC()
    var folderIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    private var isSearching: Bool = false
    private var searchedFolders:[Folder] = [] {
        didSet{
            DispatchQueue.main.async {
                self.folderTableView.reloadData()
            }
            if isSearching{
                toggleViews(data: self.searchedFolders)
            }
        }
    }
    private var folders:[Folder] = [] {
        didSet{
            DispatchQueue.main.async {
                self.folderTableView.reloadData()
            }
            toggleViews(data: self.folders)
        }
    }
    private let viewModel = FolderViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.bg
        configureNavBar()
        setupViews()
        setupContraints()
        getFolderData()
        configureBackButton()
        configureSearchBar()
        toggleViews(data: folders)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
        title = "My folders"
        navigationController?.navigationBar.isHidden = false
    }
   
    func getFolderData(){
        viewModel.getFolders()
        cancellables = viewModel.$folders.sink { data in
            self.folders = data
            self.folders.reverse()
        }
    }
    
    // MARK: Properties -
    lazy var searchBarController =  UISearchController()
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
        tv.backgroundColor = .clear
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
    
    func presentNoteVC(folder: Folder){
        let vc = NotesVC()
        vc.folder = folder
        navigationController?.pushViewController(vc, animated: true)
    }
  
    @objc func didTapMoreImage(_ sender: UIButton){
        childVC.preferredContentSize  = CGSize(width: Int(view.frame.width), height: 180)
        childVC.delegate = self
        childVC.options = BottomSheetOptionType.folderData
        presentBottomSheet(
            viewController: childVC,
            configuration:  BottomSheetConfiguration(
                cornerRadius: 30,
                pullBarConfiguration: .visible(.init(height: 20)),
                shadowConfiguration: .init(backgroundColor: UIColor.black.withAlphaComponent(0.6))
            ))
    }
    func toggleViews(data: [Folder]){
        if data.count > 0 {
            folderTableView.isHidden = false
            folderTableView.alpha = 1
            
            emptyLabel.isHidden = true
            emptyLabel.alpha = 0
        }
        else {
            emptyLabel.isHidden = false
            emptyLabel.alpha = 1
        }
    }
}

extension FolderVC:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let folder: Folder
        if isSearching {
            folder = searchedFolders[indexPath.row]
        }else {
            folder = folders[indexPath.row]
        }
        presentNoteVC(folder: folder)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215.0
    }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = folderTableView.cellForRow(at: IndexPath(row: indexPath.row, section: 0)) as! FolderCell
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseIn) {
         cell.transform = CGAffineTransform(scaleX: 0.95, y:0.95)
        } completion: { (_) in
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseIn, animations: {
             cell.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion:nil)
        }
    }
    
}

extension FolderVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchedFolders.count
        }else {
            return folders.count
        }
       
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FolderCell.reusableId, for: indexPath) as! FolderCell
        let item: Folder
        if isSearching {
            item = searchedFolders[indexPath.row]
        }else {
            item = folders[indexPath.row]
        }
        cell.data = item
        cell.delegate = self
        cell.controller = self
        cell.selectionStyle = .none
        return cell
    }
}

extension FolderVC {
    func configureNavBar(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font.semi_bold.rawValue, size: 15.0)!,NSAttributedString.Key.foregroundColor: Color.text_color_heading]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font.bold.rawValue, size: 24.0)!,NSAttributedString.Key.foregroundColor: Color.text_color_heading]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.largeContentTitle = "My folders"
        self.navigationController?.navigationItem.title = "My foldlers"
        
        
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
        
        let fullName = userDefaultManager.getUserFullName().getUserInitials()
        let avatarView = UIButton(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        avatarView.backgroundColor = Color.dark
        avatarView.layer.cornerRadius = 36/2
        avatarView.setTitle(fullName, for: .normal)
        avatarView.setTitleColor(.white, for: .normal)
        avatarView.titleLabel?.font = UIFont(name: Font.semi_bold.rawValue, size: 16)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: avatarView)
        
        let rightBarItem = UIBarButtonItem()
        rightBarItem.customView = avatarView
        navigationItem.setRightBarButtonItems([rightBarItem], animated: true)
    }
    
    func setupAttributedText(_ title: String,_ subTitle: String) -> NSAttributedString{
        let text = NSMutableAttributedString(string: title, attributes: [.foregroundColor: Color.dark,.font: UIFont(name: Font.semi_bold.rawValue, size: 18)!])
        text.append(NSAttributedString(string: "\n\n\(subTitle)", attributes: [.foregroundColor: Color.dark.withAlphaComponent(0.8),.font: UIFont(name: Font.medium.rawValue, size: 16)!]))
        return text
    }
    func configureSearchBar(){
        let searchBar = searchBarController.searchBar.searchTextField
        navigationItem.searchController = searchBarController
        searchBarController.obscuresBackgroundDuringPresentation = false
        searchBarController.searchBar.delegate = self
        searchBarController.delegate = self
        searchBarController.searchResultsUpdater = self
        searchBarController.searchBar.barTintColor = Color.grey
        
        // searchbar properties
        searchBar.layer.cornerRadius = 10
        searchBar.font = UIFont(name: Font.medium.rawValue, size: 16)
        searchBar.textColor = Color.text_color_heading
        searchBar.clipsToBounds = true
        searchBar.clearButtonMode = .whileEditing
        searchBar.attributedPlaceholder = NSAttributedString(string: "Search folders", attributes: [NSAttributedString.Key.foregroundColor: Color.text_color_normal,NSAttributedString.Key.font: UIFont(name: Font.regular.rawValue, size: 14)!])
    }
}

extension FolderVC: BottomSheetItemDelegate, OptionCellDelegate {
    func getCellPressed(in cell: UITableViewCell) {
        guard let indexPath = folderTableView.indexPath(for: cell) else {
               return
           }
        self.folderIndexPath = IndexPath(row: indexPath.row, section: 0)
    }
    
    
    func deleteItem() {
        dismiss(animated: true, completion: nil)
        let alert = UIAlertController()
        self.presentAlertWarning(title: "Delete this folder", message: "Are you really sure you want to delete this folder? You'll lose all related notes") { results in
            switch results{
            case.success( let action):
                if action == .yes{
                    self.deleteFolder()
                }
                else if action == .no{
                    alert.dismiss(animated: true, completion: nil)
                }
            case .failure(_):
                break
            }
            return nil
        }
    }
    func editItem() {
        dismiss(animated: true, completion: nil)
        let item = folderIndexPath
        let folderObject  = self.folders[item.row]
        presentEditFolderVC(folder: folderObject)
    }
    
    func deleteFolder(){
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

extension FolderVC: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            isSearching = true
            searchedFolders = folders.filter({ data in
                data.heading!.lowercased().prefix(searchText.count) == searchText.lowercased()
            })
        }
        else {
            isSearching = false
        }
      
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let button = searchBar.value(forKey: "cancelButton") as? UIButton {
            button.titleLabel?.font = UIFont(name: Font.medium.rawValue, size: 14)
            button.setTitleColor(Color.text_color_heading, for: .normal)
        }
        
    }
}

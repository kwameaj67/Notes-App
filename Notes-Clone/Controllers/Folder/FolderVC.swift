//
//  ViewController.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 09/10/2022.
//

import UIKit

class FolderVC: UIViewController {
    let folders = FolderType.data
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "folders"
        view.backgroundColor = Color.dark
        configureNavBar()
        setupViews()
        setupContraints()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    // MARK: Properties -
    let addButton: UIButton = {
        var btn = UIButton()
        let image = UIImage(systemName: "plus",withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        btn.setImage(image, for: .normal)
        btn.tintColor = .white
        btn.titleLabel?.font = UIFont(name: "", size: 16)
        btn.backgroundColor = Color.red
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(createFolder), for: .touchUpInside)
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
        addButton.bringSubviewToFront(folderTableView)
    }
    func configureNavBar(){

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font.bold.rawValue, size: 22.0)!,NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font.bold.rawValue, size: 36.0)!,NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeContentTitle = "folders"
        
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            folderTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            folderTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            folderTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            folderTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 90),
            addButton.widthAnchor.constraint(equalToConstant: 90),
        ])
    }
    
    @objc func createFolder(){
        let vc = AddFolderVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

extension FolderVC:UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return folders.count
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
        let item = folders[indexPath.section]
        print(item.title)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210.0
    }
}

extension FolderVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FolderCell.reusableId, for: indexPath) as! FolderCell
        cell.setupCell(for: folders[indexPath.section])
        cell.selectionStyle = .none
        return cell
    }
   
}

//
//  FolderOptionsVC.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 27/10/2022.
//

import UIKit

protocol BottomSheetItemDelegate: AnyObject {
    func deleteItem()
    func editItem()
}

class BottomSheetVC: UIViewController {
    
    let options = FolderOptionType.data
    weak var delegate : BottomSheetItemDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.bg
        setupViews()
        setupContraints()
    }
    
    // MARK: Properties
    
    lazy var optionTableView: UITableView = {
        let tb = UITableView(frame: .zero,style: .plain)
        tb.register(FolderOptionCell.self, forCellReuseIdentifier: FolderOptionCell.reusableId)
        tb.delegate = self
        tb.dataSource = self
        tb.allowsMultipleSelection = false
        tb.allowsSelection = true
        tb.bounces = false
        tb.alwaysBounceVertical = false
        tb.separatorStyle = .none
        tb.showsVerticalScrollIndicator = false
        tb.backgroundColor = .clear
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    func setupViews(){
        view.addSubview(optionTableView)
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            optionTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            optionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            optionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            optionTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
    }
  
}

extension BottomSheetVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FolderOptionCell.reusableId, for: indexPath) as! FolderOptionCell
        let item = options[indexPath.row]
        cell.setupCell(item: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _ = options[indexPath.row]
        if indexPath.row == 0 {
            delegate?.editItem()
        }
        if indexPath.row == 1 {
            delegate?.deleteItem()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

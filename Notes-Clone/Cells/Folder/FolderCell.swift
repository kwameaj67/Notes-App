//
//  FolderCell.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 11/10/2022.
//

import UIKit

class FolderCell: UITableViewCell {
    
   
    static let reusableId = "FolderCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: FolderCell.reusableId)
        setupViews()
        setupContraints()
        layer.cornerRadius = 20
        layer.masksToBounds = true
        backgroundColor = Color.cell_dark_bg
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Propeties -
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: Font.medium.rawValue, size: 16)
        lb.textColor = Color.grey
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let countLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: Font.semi_bold.rawValue, size: 66)
        lb.textColor = .white
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let arrowImage : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.right",withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    func setupCell(for item: FolderType){
        titleLabel.text = item.title.lowercased()
        countLabel.text = "\(item.totalCount)"
    }
    func setupViews(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(arrowImage)
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: -20),
            
            arrowImage.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            countLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            countLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    
}

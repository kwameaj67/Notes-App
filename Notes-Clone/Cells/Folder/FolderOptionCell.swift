//
//  FolderOptionCell.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 27/10/2022.
//

import UIKit

class FolderOptionCell: UITableViewCell {

    static let reusableId = "FolderOptionCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: FolderOptionCell.reusableId)
        setupViews()
        setupContraints()
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Properties -
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: Font.medium.rawValue, size: 18)
        lb.textColor = Color.text_color_heading
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let icon : UIImageView = {
        var iv = UIImageView()
        iv.tintColor = Color.text_color_heading
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    func setupViews(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(icon)
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            icon.heightAnchor.constraint(equalToConstant: 23),
            icon.widthAnchor.constraint(equalToConstant: 23),
            
            titleLabel.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
        ])
    }
    func setupCell(item: FolderOptionType){
        titleLabel.text = item.name
        icon.image = UIImage(named: item.icon)?.withRenderingMode(.alwaysTemplate)
    }
}

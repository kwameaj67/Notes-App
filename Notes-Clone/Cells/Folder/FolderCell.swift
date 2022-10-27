//
//  FolderCell.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 11/10/2022.
//

import UIKit

class FolderCell: UITableViewCell {
    
    var controller : FolderVC? {
        didSet{
            arrowImage.addGestureRecognizer(UITapGestureRecognizer(target: controller, action: #selector(FolderVC.didTapMoreImage)))
        }
    }
    
    static let reusableId = "FolderCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: FolderCell.reusableId)
        setupViews()
        setupContraints()
        backgroundColor = Color.cell_dark_bg
    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
//     }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Propeties -
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: Font.medium.rawValue, size: 16)
        lb.textColor = .systemGray2
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let countLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: Font.semi_bold.rawValue, size: 26)
        lb.textColor = .white
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let dateLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: Font.medium.rawValue, size: 14)
        lb.textColor = .systemGray2
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    lazy var arrowImage : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "ellipsis",withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold))
        iv.tintColor = .systemGray2
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    func setupCell(for item: Folder){
        guard let heading = item.heading else { return }
        guard let noteCount = item.notes?.count else { return }
        guard let date = item.createdAt else { return }
        
        titleLabel.text = heading
        countLabel.text = "\(noteCount)"
        dateLabel.text = "\(date.timeAgoDisplay())"

    }
    func setupViews(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(arrowImage)
        contentView.addSubview(dateLabel)
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
            
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }  
}

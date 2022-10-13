//
//  NumberPadCell.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 10/10/2022.
//

import UIKit

class NumberPadCell: UICollectionViewCell {
    
    static let reusableId = "NumberPadCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Properties -
    let label: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: Font.medium.rawValue, size: 25)
        lb.textColor = Color.dark
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let iconImage : UIImageView = {
        var iv = UIImageView()
        iv.tintColor = .systemGray2
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isHidden = true
        iv.alpha = 0
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    func setupViews(){
        addSubview(label)
        addSubview(iconImage)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.widthAnchor.constraint(equalTo: widthAnchor),
            label.heightAnchor.constraint(equalTo: heightAnchor),
            
            
            iconImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImage.widthAnchor.constraint(equalToConstant: 26),
            iconImage.heightAnchor.constraint(equalToConstant: 26),
        ])
    }
    
    func setupCell(for item: NumberPad){
        if let text = item.name {
            label.text = text
        }
        if let imageName = item.image {
            iconImage.image = UIImage(systemName: imageName,withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .medium))
            iconImage.isHidden = false
            iconImage.alpha = 1
            
            label.isHidden = true
            label.alpha = 0
        }
        
    }
}

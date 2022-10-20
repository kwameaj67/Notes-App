//
//  CategoryCell.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 13/10/2022.
//

import UIKit

class CategoryTypeCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.layer.borderWidth = self.isSelected ? 1 : 1
                self.layer.borderColor = self.isSelected ? Color.cell_dark_bg.cgColor :UIColor.systemGray2.cgColor
                self.layer.backgroundColor = self.isSelected ? Color.red.cgColor : UIColor.clear.cgColor
            }
        }
    }
    static let reusableId = "CategoryTypeCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
        backgroundColor = .clear
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray2.cgColor
        layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Properties -
    let label: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: Font.medium.rawValue, size: 14)
        lb.textColor = .white
        lb.isUserInteractionEnabled = false
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    func setupViews(){
        addSubview(label)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 15),
            label.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -15),
        ])
    }
    
    func setupCell(for item: CategoryType){
        label.text = item.title
    }
}
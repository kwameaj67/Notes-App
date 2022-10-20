//
//  NoteCollectionCell.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 20/10/2022.
//

import UIKit

class NoteCollectionCell: UICollectionViewCell {
    
    var data: NoteType? {
        didSet{
            setupCell()
        }
    }
    
    static let reusableId = "NoteCollectionCell"
    let bg_array = [Color.cell_dark_bg,Color.pale_blue,Color.pale_green,Color.pale_red,Color.pale_green,Color.pale_yellow,Color.pale_orange,Color.pale_violet,Color.pale_purple]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
        backgroundColor = bg_array.randomElement()
        if backgroundColor == Color.cell_dark_bg{
            titleLabel.textColor = .white
        }
        else  if [Color.pale_green,Color.pale_red,Color.pale_green,Color.pale_yellow,Color.pale_orange,Color.pale_blue,Color.pale_violet,Color.pale_purple].contains(backgroundColor){
            bodyLabel.textColor = Color.dark
        }
        else {
            titleLabel.textColor = Color.dark
        }
       
        layer.cornerRadius = 20
        clipsToBounds = true
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Properties -
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: Font.semi_bold.rawValue, size: 17)
        lb.numberOfLines = 2
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let bodyLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: Font.medium.rawValue, size: 16)
        lb.textColor = .systemGray2
        lb.numberOfLines = 10
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    func setupViews(){
        addSubview(titleLabel)
        addSubview(bodyLabel)
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            bodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
    }
    func setupCell(){
        guard let item = data else {return}
        titleLabel.text = item.heading
        bodyLabel.text = item.body
    }
}

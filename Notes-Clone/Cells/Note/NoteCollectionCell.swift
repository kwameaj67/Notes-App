//
//  NoteCollectionCell.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 20/10/2022.
//

import UIKit

protocol NoteCellDelegate: AnyObject {
    func getCellPressed(in cell: UICollectionViewCell)
}

class NoteCollectionCell: UICollectionViewCell {
    var data: Note? {
        didSet{
            setupCell()
        }
    }
    weak var delegate: NoteCellDelegate?
    static let reusableId = "NoteCollectionCell"
    
    var controller : NotesVC? {
        didSet{
            moreButton.addTarget(controller, action: #selector(NotesVC.didTapMoreImage), for: .touchUpInside)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
        backgroundColor = Color.pad_bg
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
        lb.textColor = Color.dark
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let bodyLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: Font.medium.rawValue, size: 16)
        lb.textColor = Color.text_color_normal
        lb.numberOfLines = 10
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    lazy var moreButton : UIButton = {
        let b = UIButton()
        let image = UIImage(systemName: "ellipsis",withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold))
        b.setImage(image, for: .normal)
        b.tintColor = Color.dark
        b.backgroundColor = .clear
        b.addTarget(self, action: #selector(didTapButton), for: .primaryActionTriggered)
        b.adjustsImageWhenHighlighted = false
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
   
    @objc func didTapButton(){
        delegate?.getCellPressed(in: self)
    }
    
    func setupViews(){
        addSubview(titleLabel)
        addSubview(bodyLabel)
        addSubview(moreButton)
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: moreButton.leadingAnchor, constant: -5),

            moreButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            moreButton.heightAnchor.constraint(equalToConstant: 30),
            moreButton.widthAnchor.constraint(equalToConstant: 30),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14),
            bodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
        ])
    }
    func setupCell(){
        guard let item = data else { return }
        titleLabel.text = item.heading
        bodyLabel.text = item.body
    }
    func randomizeCellColor(){
        let bg_array = [Color.cell_dark_bg,Color.pale_blue,Color.pale_green,Color.pale_red,Color.pale_green,Color.pale_yellow,Color.pale_orange,Color.pale_violet,Color.pale_purple]
        backgroundColor = bg_array.randomElement()
        if backgroundColor == Color.cell_dark_bg{
            titleLabel.textColor = .white
            bodyLabel.textColor = .white
            moreButton.tintColor = .white
        }
        else  if [Color.pale_green,Color.pale_red,Color.pale_green,Color.pale_yellow,Color.pale_orange,Color.pale_blue,Color.pale_violet,Color.pale_purple].contains(backgroundColor){
            bodyLabel.textColor = Color.dark
        }
        else {
            titleLabel.textColor = Color.dark
        }
    }
}

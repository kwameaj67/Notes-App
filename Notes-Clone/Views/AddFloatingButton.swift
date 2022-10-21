//
//  AddFloatingButton.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 21/10/2022.
//

import UIKit

class AddFloatingButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let image = UIImage(systemName: "plus",withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        setImage(image, for: .normal)
        tintColor = .white
        titleLabel?.font = UIFont(name: "", size: 16)
        backgroundColor = Color.red
        layer.cornerRadius = 20
        adjustsImageWhenHighlighted = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//
//  NButton.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 10/10/2022.
//

import UIKit

class NButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Color.dark
        layer.cornerRadius = self.frame.height/2
        layer.masksToBounds = false
        setTitleColor(.white, for: .normal)
        adjustsImageWhenHighlighted = false
        titleLabel?.font = UIFont(name: Font.semi_bold.rawValue, size: 16)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

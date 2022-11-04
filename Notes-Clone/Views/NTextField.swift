//
//  CustomTextField.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 09/10/2022.
//

import UIKit

class NTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        borderStyle = .none
        backgroundColor = Color.pad_bg
        textColor = Color.dark
        font = UIFont(name: Font.medium.rawValue, size: 15)
        layer.masksToBounds = true
        layer.borderWidth = 0.0
        layer.cornerRadius = 52/2
        autocorrectionType = .no
        autocapitalizationType = .none
        clearButtonMode = .whileEditing
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 24, dy: 0)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 24, dy: 0)
    }

}


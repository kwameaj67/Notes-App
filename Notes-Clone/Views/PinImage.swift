//
//  PinImage.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 10/10/2022.
//

import UIKit

class PinImage: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        image = UIImage(named: "asterisk")?.withRenderingMode(.alwaysTemplate)
        tintColor = .systemGray4
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

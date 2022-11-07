//
//  String+Ext.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 24/10/2022.
//

import Foundation

extension String {
    
    func getUserInitials() -> String{
        let names = self.components(separatedBy: " ")

        let firstNameInitials = names[0].prefix(1)
        let lastNameInitials = names[1].prefix(1)
    
        return  "\(firstNameInitials)\(lastNameInitials)".uppercased()
    }
    
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

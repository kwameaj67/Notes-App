//
//  Int+Ext.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 07/11/2022.
//

import Foundation

extension Int{
    func checkValidCellNumber() -> Int{
        let list = [2,8,14,20,26,32]
        if list.contains(self){
            return self
        }
        return 0
    }
}

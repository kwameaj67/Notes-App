//
//  UserDefaultsManager.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 24/10/2022.
//

import UIKit


class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    let userDefaults = UserDefaults.standard
    
    private init() {}
    
    func setUserLogIn(){
        userDefaults.setValue(true, forKey: "isLoggedIn")
    }
    
    func setUserFullName(fullName: String){
        userDefaults.setValue(fullName, forKey: "userFullName")
    }
    
    func getUserFullName() -> String{
        let name = userDefaults.string(forKey: "userFullName")
        return name ?? "No Name"
    }
    
}

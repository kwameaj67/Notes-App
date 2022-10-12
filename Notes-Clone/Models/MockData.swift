//
//  MockData.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 11/10/2022.
//

import UIKit


struct FolderType{
    var title: String
    var totalCount: Int
    
    static let data:[FolderType] = [
        FolderType(title: "personal notes", totalCount: 23),
        FolderType(title: "feelings", totalCount: 30),
        FolderType(title: "morning quotes", totalCount: 451),
        FolderType(title: "great ideas", totalCount: 32),
        FolderType(title: "schooling", totalCount: 15),
        FolderType(title: "to-do", totalCount: 66),
        FolderType(title: "passwords", totalCount: 40),
    ]
}

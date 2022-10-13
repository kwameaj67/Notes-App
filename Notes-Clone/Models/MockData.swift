//
//  MockData.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 11/10/2022.
//

import UIKit


struct FolderType{
    var title: String
    var totalCount: Int?
    
    static let data:[FolderType] = [
        FolderType(title: "personal notes", totalCount: 23),
        FolderType(title: "feelings", totalCount: 30),
        FolderType(title: "morning quotes", totalCount: nil),
        FolderType(title: "great ideas", totalCount: 32),
        FolderType(title: "schooling", totalCount: 15),
        FolderType(title: "to-do", totalCount: 66),
        FolderType(title: "passwords", totalCount: 40),
    ]
}

struct CategoryType{
    var title: String
    static let data = [
        CategoryType(title:"📚 Academic"),
        CategoryType(title:"🏥 Health"),
        CategoryType(title:"🎓 School"),
        CategoryType(title:"🤐 Secret"),
        CategoryType(title:"💍 Wedding"),
        CategoryType(title:"🎶 Music"),
        CategoryType(title:"💼 Work"),
        CategoryType(title:"⚙️ Electronic"),
        CategoryType(title:"🥳 Events"),
        CategoryType(title:"👍🏽 Likes"),
        CategoryType(title:"🌚 Disklikes"),
        CategoryType(title:"💃 Adventure"),
        CategoryType(title:"✍️ Goals"),
        CategoryType(title:"🤑 Cash receipts"),
        CategoryType(title:"💰 Savings"),
        CategoryType(title:"🍿 Movies"),
        CategoryType(title:"👨‍💻 Technology"),
        CategoryType(title:"🔗 General Links"),
        CategoryType(title:"🏋🏽‍♀️ Workout"),
        CategoryType(title:"🎉 Birthdays")
    ]
}

//
//  FolderViewModel.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 13/10/2022.
//

import Foundation
import Combine


class FolderViewModel {
    
    var folderType : FolderServiceProtocol
    @Published var folders:[Folder] = []
    
    init(folderType : FolderServiceProtocol = FolderService()) {
        self.folderType = folderType
    }
    
    func addFolder(category:String,heading:String,completion: (() -> Void?) ){
        let newFolder = folderType.createFolder(category: category, heading: heading)
        print("\(newFolder.heading!)\n\(newFolder.category!)\n\(newFolder.createdAt!)")
    }
    
    func getFolders(){
        let data = folderType.fetchFolders()
        self.folders = data
    }
    
    func deleteFolder(folder:Folder){
        folderType.deleteFolder(folder: folder)
    }
    
    func updateFolder(heading:String, category:String, lastUpdated:Date){
       let updatedFolder = folderType.updateFolder(heading: heading, category: category, lastUpdated: lastUpdated)
        print("\(updatedFolder.heading!)\n\(updatedFolder.category!)\n\(updatedFolder.lastUpdated!)")
    }
}

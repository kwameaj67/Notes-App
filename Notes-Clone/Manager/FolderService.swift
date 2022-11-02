//
//  FolderService.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 13/10/2022.
//

import Foundation


protocol FolderServiceProtocol {
    func createFolder(category:String, heading:String) -> Folder
    func fetchFolders() -> [Folder]
    func deleteFolder(folder: Folder)
    func updateFolder(folder: Folder, heading:String, category:String, lastUpdated:Date) -> Folder
    func fetchNotes(folder: Folder) -> [Note]
}

class FolderService: FolderServiceProtocol {
  
    var context = CoreDataManager.shared.context
    
    func createFolder(category:String,heading:String) -> Folder {
        let folder = Folder(context: context)
        folder.id = UUID()
        folder.category = category
        folder.heading = heading
        folder.createdAt = Date().getDate()
        folder.lastUpdated = Date().getDate()
        folder.notes = []
        saveChanges()
        return folder
    }
    func fetchFolders() -> [Folder] {
        let folders:[Folder] = try! context.fetch(Folder.fetchRequest())
        return folders
    }
    func deleteFolder(folder: Folder){
        do {
            context.delete(folder)
            print("folder deleted")
            saveChanges()
        }
    }
    func updateFolder(folder: Folder, heading:String, category:String, lastUpdated:Date) -> Folder {
        folder.heading = heading
        folder.category = category
        folder.lastUpdated = lastUpdated
        saveChanges()
        return folder
    }
    func fetchNotes(folder: Folder) -> [Note] {
        return folder.notesArray
    }
    
    
    func saveChanges(){
        if context.hasChanges {
            do {
                try context.save()
                print("saved")
            } catch let error{
                print("Something went wrong whilst saving data!\(error.localizedDescription)")
            }
        }
    }
}

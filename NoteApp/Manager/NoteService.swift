//
//  NoteService.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 14/10/2022.
//

import Foundation
import CoreData

protocol NoteServiceProtocol {
    func createNote(folder: Folder, heading:String, body:String) -> Note
    func deleteNote(note: Note)
    func updateNote(note: Note, heading:String, body:String, lastUpdated:Date) -> Note
//    func starNote(folder: Folder, isStarred: Bool) -> Note
}

class NoteService: NoteServiceProtocol {
  
    var context = CoreDataManager.shared.context
    
    func createNote(folder: Folder, heading:String, body:String) -> Note {
        let note = Note(context: context)
        note.id = UUID()
        note.heading = heading
        note.body = body
        note.createdAt = Date().getDate()
        note.lastUpdated = Date().getDate()
        note.folder = folder
        saveChanges()
        return note
    }
    func deleteNote(note: Note){
        do {
            context.delete(note)
          //  print("note deleted")
            saveChanges()
        }
    }
    func updateNote(note: Note, heading:String, body:String, lastUpdated:Date) -> Note  {
        note.heading = heading
        note.body = body
        note.lastUpdated = lastUpdated
        
        saveChanges()
        return note
    }
//    func starNote(folder: Folder, isStarred: Bool) -> Note {
//        let note = Note()
//        note.isStarred = isStarred
//        note.folder = folder
//        
//        saveChanges()
//        return note
//    }
   
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

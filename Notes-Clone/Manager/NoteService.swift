//
//  NoteService.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 14/10/2022.
//

import Foundation

protocol NoteServiceProtocol {
    func createNote(heading:String,body:String) -> Note
    func fetchNotes() -> [Note]
    func deleteNote(note: Note)
    func updateNote(heading:String,body:String,lastUpdated:Date) -> Note
}

class NoteService: NoteServiceProtocol {
  
    var context = CoreDataManager.shared.context
    
    func createNote(heading:String,body:String) -> Note {
        let note = Note(context: context)
        note.id = UUID()
        note.heading = heading
        note.body = body
        note.createdAt = Date().getDate()
        note.lastUpdated = Date().getDate()

        saveChanges()
        return note
    }
    func fetchNotes() -> [Note] {
        print("fetch notes")
        let notes:[Note] = try! context.fetch(Note.fetchRequest())
        return notes
    }
    func deleteNote(note: Note){
        do {
            context.delete(note)
            print("folder deleted")
            saveChanges()
        }
    }
    func updateNote(heading:String,body:String,lastUpdated:Date) -> Note  {
        let note = Note()
        note.heading = heading
        note.body = body
        note.lastUpdated = lastUpdated
        
        saveChanges()
        return note
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

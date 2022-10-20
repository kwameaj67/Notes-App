//
//  NoteViewModel.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 14/10/2022.
//

import Foundation
import Combine


class NoteViewModel {
    var noteType: NoteServiceProtocol
    @Published var notes:[Note] = []
    
    init(noteType: NoteServiceProtocol = NoteService()) {
        self.noteType = noteType
    }
    
    func addNote(heading:String,body:String){
        let newNote = noteType.createNote(heading: heading, body: body)
        print("\(newNote.heading!)\n\(newNote.body!)\n\(newNote.createdAt!)")
    }
    
    func getNotes(){
        let data = noteType.fetchNotes()
        self.notes = data
    }
    
    func deleteNote(note: Note){
        noteType.deleteNote(note: note)
    }
    
    func updateNote(heading:String,body:String,lastUpdated:Date){
       let updateNote = noteType.updateNote(heading: heading, body: body, lastUpdated: lastUpdated)
        print("\(updateNote.heading!)\n\(updateNote.body!)\n\(updateNote.lastUpdated!)")
    }
}

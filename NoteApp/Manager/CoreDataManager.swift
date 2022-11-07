//
//  CoreDataManager.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 12/10/2022.
//

import UIKit
import CoreData



class CoreDataManager {
    
    static let shared = CoreDataManager(modelName: "MyApp")
    
    let persistentContainer: NSPersistentContainer
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func loadStore(completion: (() -> Void? )){
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Unresolved error \(error.localizedDescription)")
            }
        }
        completion()
    }
}

//
//  Note+CoreDataClass.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 12/10/2022.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject, Comparable {
    public static func < (lhs: Note, rhs: Note) -> Bool {
        if lhs.createdAt! < rhs.createdAt! {
            return true
        }
        return false
    }
}

//
//  Note+CoreDataClass.swift
//  MicroNotes
//
//  Created by Andrey Chernoprudov on 08.06.2021.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {
    @NSManaged
    public var title: String
    @NSManaged
    public var timestamp: Date
    @NSManaged
    public var text: String
}

public extension Note {
    class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }
}

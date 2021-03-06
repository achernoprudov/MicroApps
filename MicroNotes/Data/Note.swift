//
//  Note.swift
//  MicroNotes
//
//  Created by Andrey Chernoprudov on 08.06.2021.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject, Identifiable {
    @NSManaged
    public var timestamp: Date
    @NSManaged
    public var text: String
}

public extension Note {
    var listId: String {
        "\(id) + \(title)"
    }
    
    var title: String {
        text.split(separator: "\n").first?.description ?? ""
    }
}

public extension Note {
    class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }
    
    class func fetchAll(with context: NSManagedObjectContext) throws -> [Note] {
        let request: NSFetchRequest<Note> = fetchRequest()
        return try context.fetch(request)
    }
}

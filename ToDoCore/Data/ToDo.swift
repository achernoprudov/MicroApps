//
//  ToDo.swift
//  ToDoCore
//
//  Created by Andrey Chernoprudov on 10.06.2021.
//
//

import CoreData

@objc(ToDo)
public class ToDo: NSManagedObject {
    @NSManaged
    public var created: Date
    @NSManaged
    public var title: String
    @NSManaged
    public var done: Bool
    @NSManaged
    public var doneAt: Date?
}

extension ToDo: Identifiable {
    public var id: NSManagedObjectID { objectID }
}

public extension ToDo {
    
    var listIdentifier: String {
        "\(objectID):\(done)"
    }
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        created = Date()
    }
    
    override func willSave() {
        super.willSave()
        
        let doneAt: Date? = done ? Date() : nil
        setPrimitiveValue(doneAt, forKey: #keyPath(ToDo.doneAt))
    }
}

public extension ToDo {
    @nonobjc class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }
    
    @nonobjc
    class func fetchTopUncompleted(
        with context: NSManagedObjectContext
    ) throws -> [ToDo] {
        let request = NSFetchRequest<ToDo>(entityName: "ToDo")
        request.fetchLimit = 10
        request.predicate = NSPredicate(format: "%K = NO", #keyPath(ToDo.done))
        
        return try context.fetch(request)
    }
}

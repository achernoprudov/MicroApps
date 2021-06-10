//
//  ToDo.swift
//  MicroToDo
//
//  Created by Andrey Chernoprudov on 10.06.2021.
//
//

import CoreData

@objc(ToDo)
public class ToDo: NSManagedObject, Identifiable {
    @NSManaged
    public var created: Date
    @NSManaged
    public var title: String
    @NSManaged
    public var done: Bool
    @NSManaged
    public var doneAt: Date?
}

extension ToDo {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }
}

//
//  CodeItem.swift
//  MicroCodes
//
//  Created by Andrey Chernoprudov on 17.10.2021.
//

import CoreData

@objc(CodeItem)
public class CodeItem: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CodeItem> {
        return NSFetchRequest<CodeItem>(entityName: "CodeItem")
    }

    @NSManaged public var title: String
    @NSManaged public var creationDate: Date
}

extension CodeItem: Identifiable {
    public var id: NSManagedObjectID { objectID }
}

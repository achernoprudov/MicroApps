//
//  Location.swift
//  MicroTime
//
//  Created by Andrey Chernoprudov on 25.10.2021.
//

import CoreData

@objc(Location)
public class Location: NSManagedObject {
    @NSManaged public var timeZoneId: String
    @NSManaged public var creationDate: Date
}

extension Location: Identifiable {
    public var id: NSManagedObjectID {
        objectID
    }
}

//
//  DateItem.swift
//  MicroDates
//
//  Created by Andrey Chernoprudov on 29.11.2022.
//

import CoreData

@objc(DateItem)
public class DateItem: NSManagedObject {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<DateItem> {
    return NSFetchRequest<DateItem>(entityName: "DateItem")
  }
  
  @NSManaged public var title: String
  @NSManaged public var creationDate: Date
  @NSManaged public var targetDate: Date
  @NSManaged public var color: Data
  
  public override func awakeFromInsert() {
    super.awakeFromInsert()
    creationDate = Date()
  }
}

extension DateItem: Identifiable {
  public var id: NSManagedObjectID { objectID }
}


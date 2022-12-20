//
//  DateItem.swift
//  MicroDates
//
//  Created by Andrey Chernoprudov on 29.11.2022.
//

import CoreData

@objc(DateItem)
public class DateItem: NSManagedObject {
  @NSManaged public var title: String
  @NSManaged public var creationDate: Date
  @NSManaged public var targetDate: Date
  
  public override func awakeFromInsert() {
    super.awakeFromInsert()
    creationDate = Date()
  }
}

extension DateItem: Identifiable {
  public var id: NSManagedObjectID { objectID }
}

/// # Requests
extension DateItem {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<DateItem> {
    return NSFetchRequest<DateItem>(entityName: "DateItem")
  }
  
  class func fetchAll(with context: NSManagedObjectContext) throws -> [DateItem] {
      let request: NSFetchRequest<DateItem> = fetchRequest()
      return try context.fetch(request)
  }
}

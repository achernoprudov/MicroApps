//
//  DetailsPage.swift
//  MicroDates
//
//  Created by Andrey Chernoprudov on 20.12.2022.
//

import SwiftUI
import CoreData
import Core

struct DetailsPage: View {
  @Environment(\.managedObjectContext)
  private var viewContext
  
  let dateItemId: NSManagedObjectID
  
  @State
  var title: String = ""
  @State
  var targetDate: Date = Date()
  @State
  var color: Color = .blue
  
  @State
  var dateItem: DateItem?
  
  var body: some View {
    VStack {
      if let item = dateItem {
        DetailsContainer(
          title: $title,
          targetDate: $targetDate,
          color: $color,
          creationDate: item.creationDate
        )
      } else {
        Text("Loading")
      }
    }
    .onAppear {
      if let item = viewContext.object(with: dateItemId) as? DateItem {
        dateItem = item
      }
    }
    .onDisappear {
      dateItem?.title = title
      dateItem?.targetDate = targetDate
      
      viewContext.saveOrCrash()
    }
  }
}

struct DetailsPage_Previews: PreviewProvider {
  static var previews: some View {
    let context = PersistenceController.preview.container.viewContext
    let items = try! DateItem.fetchAll(with: context)
    let first = items.first!
    
    return DetailsPage(dateItemId: first.objectID)
      .environment(\.managedObjectContext, context)
  }
}

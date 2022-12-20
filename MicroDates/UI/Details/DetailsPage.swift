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
  
  let dateItem: DateItem
  let dismissPage: () -> Void
  
  @State
  var title: String
  @State
  var targetDate: Date
  @State
  var color: Color = .blue
  
  init(dateItem: DateItem, dismissPage: @escaping () -> Void) {
    self.dateItem = dateItem
    self.dismissPage = dismissPage
    self._title = State(initialValue: dateItem.title)
    self._targetDate = State(initialValue: dateItem.targetDate)
  }
  
  var body: some View {
    DetailsContainer(
      title: $title,
      targetDate: $targetDate,
      color: $color,
      creationDate: dateItem.creationDate,
      onDelete: deleteItem
    )
    .onDisappear(perform: saveOrDelete)
  }

  private func saveOrDelete() {
    if title.isEmpty {
      viewContext.delete(dateItem)
    } else {
      dateItem.title = title
      dateItem.targetDate = targetDate
    }
    
    viewContext.saveOrCrash()
  }
  
  private func deleteItem() {
    title = ""
    dismissPage()
  }
}

struct DetailsPage_Previews: PreviewProvider {
  static var previews: some View {
    let context = PersistenceController.preview.container.viewContext
    let items = try! DateItem.fetchAll(with: context)
    
    return DetailsPage(dateItem: items.first!, dismissPage: {})
      .environment(\.managedObjectContext, context)
  }
}

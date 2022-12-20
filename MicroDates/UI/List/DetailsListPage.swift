//
//  DetailsListPage.swift
//  MicroDates
//
//  Created by Andrey Chernoprudov on 20.12.2022.
//

import SwiftUI

struct DetailsListPage: View {
  
  @Environment(\.managedObjectContext)
  private var viewContext
  
  @FetchRequest(
    sortDescriptors: [
      NSSortDescriptor(keyPath: \DateItem.targetDate, ascending: true)
    ],
    predicate: NSPredicate(format: "%K != ''", #keyPath(DateItem.title)),
    animation: .default
  )
  private var items: FetchedResults<DateItem>
  
  @State
  private var selectedItem: DateItem?
  
  var body: some View {
    NavigationView {
      List {
        ForEach(items) { item in
          ListItemView(
            title: item.title,
            targetDate: item.targetDate,
            color: .blue
          )
          .onTapGesture {
            selectedItem = item
          }
        }
      }
      .navigationTitle("MicroDates")
      .listStyle(PlainListStyle())
      .toolbar {
        ToolbarItem {
          Button(action: addItem) {
            Label("Add Item", systemImage: "plus")
          }
        }
      }
      .sheet(item: $selectedItem) { item in
        DetailsPage(dateItem: item)
      }
    }
  }
  
  private func addItem() {
    withAnimation {
      let newItem = DateItem(context: viewContext)
      newItem.title = ""
      newItem.targetDate = Date()
      
      selectedItem = newItem
    }
  }
}

struct DetailsListPage_Previews: PreviewProvider {
  static var previews: some View {
    DetailsListPage()
      .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}

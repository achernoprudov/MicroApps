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
      .listStyle(PlainListStyle())
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          EditButton()
        }
        ToolbarItem {
          Button(action: addItem) {
            Label("Add Item", systemImage: "plus")
          }
        }
      }
      Text("Select an item")
    }
  }
  
  private func addItem() {
    withAnimation {
      let newItem = DateItem(context: viewContext)
      newItem.targetDate = Date()
      
      do {
        try viewContext.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }
}

struct DetailsListPage_Previews: PreviewProvider {
  static var previews: some View {
    DetailsListPage()
      .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}

//
//  ContentView.swift
//  MicroCodes
//
//  Created by Andrey Chernoprudov on 21.07.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CodeItem.creationDate, ascending: true)],
        animation: .default)
    private var items: FetchedResults<CodeItem>

    var body: some View {
        List {
            ForEach(items) { item in
                CodeItemView(code: "111 222", title: item.title)
                    .listRowSeparator(.hidden)
            }
            .onDelete(perform: deleteItems)
        }
        .listStyle(PlainListStyle())
        .navigationBarItems(trailing: EditButton())
        .navigationTitle("MicroCodes")
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Spacer()

                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = CodeItem(context: viewContext)
            newItem.title = "Super code"
            newItem.creationDate = Date()

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

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

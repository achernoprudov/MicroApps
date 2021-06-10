//
//  ListContentView.swift
//  MicroToDo
//
//  Created by Andrey Chernoprudov on 09.06.2021.
//

import SwiftUI
import CoreData

struct ListContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ToDo.created, ascending: true)],
        animation: .default)
    private var items: FetchedResults<ToDo>

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            List {
                ForEach(items) { item in
                    Text("Item at \(item.created, formatter: itemFormatter)")
                }
                .onDelete(perform: deleteItems)
            }
            
            Button(action: addItem) {
                Image(systemName: "plus")
                    .foregroundColor(.white)
            }
            .frame(width: 60, height: 60, alignment: .center)
            .background(
                Circle()
                    .foregroundColor(.blue)
            )
            .padding(20)
            .shadow(radius: 10)
        }
        .navigationTitle("Micro ToDo")
        .toolbar {
            EditButton()
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = ToDo(context: viewContext)

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
        NavigationView {
            ListContentView()
        }
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

//
//  ContentView.swift
//  MicroNotes
//
//  Created by Andrey Chernoprudov on 08.06.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext)
    private var viewContext

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Note.timestamp, ascending: true)
        ],
        animation: .default
    )
    private var notes: FetchedResults<Note>

    var body: some View {
        List {
            ForEach(notes, id: \.listId) { note in
                NavigationLink(
                    destination: NoteCardView(note: note),
                    label: {
                        NoteItemView(note: note)
                    })
                
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                EditButton()
                
                Spacer()
                
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .navigationTitle("Micro notes")
    }

    private func addItem() {
        withAnimation {
            let newItem = Note(context: viewContext)
            newItem.timestamp = Date()
            newItem.text = ""

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
            offsets.map { notes[$0] }.forEach(viewContext.delete)

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
        .accentColor(.orange)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

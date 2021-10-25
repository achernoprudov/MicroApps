//
//  ContentView.swift
//  MicroNotes
//
//  Created by Andrey Chernoprudov on 08.06.2021.
//

import SwiftUI
import CoreData
import Core

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
            
            viewContext.saveOrCrash()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { notes[$0] }.forEach(viewContext.delete)
            
            viewContext.saveOrCrash()
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

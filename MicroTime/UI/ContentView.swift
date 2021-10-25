//
//  ContentView.swift
//  MicroTime
//
//  Created by Andrey Chernoprudov on 24.10.2021.
//

import SwiftUI
import CoreData
import Core

struct ContentView: View {
    @Environment(\.managedObjectContext)
    private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Location.creationDate, ascending: true)],
        animation: .default
    )
    private var items: FetchedResults<Location>
    
    @State
    var addLocationPresented = false
    
    @State
    var date = Date()

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    LocationItemView(identifier: item.timeZoneId, time: date)
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        addLocationPresented = true
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .popover(isPresented: $addLocationPresented) {
                AddLocationView { timeZone in
                    addLocationPresented = false
                    addLocation(with: timeZone)
                }
            }
            Text("Select an item")
        }
    }

    private func addLocation(with timeZone: TimeZone?) {
        guard let timeZone = timeZone else { return }
        withAnimation {
            let newItem = Location(context: viewContext)
            newItem.creationDate = Date()
            newItem.timeZoneId = timeZone.identifier
            
            viewContext.saveOrCrash()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            viewContext.saveOrCrash()
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

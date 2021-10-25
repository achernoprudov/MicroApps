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

    @State
    var addLocationPresented = false

    var body: some View {
        LocationsList()
            .navigationTitle("MicroTime")
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

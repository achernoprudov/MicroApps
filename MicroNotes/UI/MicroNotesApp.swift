//
//  MicroNotesApp.swift
//  MicroNotes
//
//  Created by Andrey Chernoprudov on 08.06.2021.
//

import SwiftUI

@main
struct MicroNotesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .accentColor(.orange)
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

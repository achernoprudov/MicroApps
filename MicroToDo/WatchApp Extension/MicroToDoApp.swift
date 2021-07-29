//
//  MicroToDoApp.swift
//  WatchApp Extension
//
//  Created by Andrey Chernoprudov on 21.07.2021.
//

import SwiftUI
import ToDoWatchCore

@main
struct MicroToDoApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

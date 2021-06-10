//
//  MicroToDoApp.swift
//  MicroToDo
//
//  Created by Andrey Chernoprudov on 09.06.2021.
//

import SwiftUI

@main
struct MicroToDoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListContentView()
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

//
//  MicroTimeApp.swift
//  MicroTime
//
//  Created by Andrey Chernoprudov on 24.10.2021.
//

import SwiftUI

@main
struct MicroTimeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

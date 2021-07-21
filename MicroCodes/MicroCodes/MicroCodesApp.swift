//
//  MicroCodesApp.swift
//  MicroCodes
//
//  Created by Andrey Chernoprudov on 21.07.2021.
//

import SwiftUI

@main
struct MicroCodesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .accentColor(.purple)
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

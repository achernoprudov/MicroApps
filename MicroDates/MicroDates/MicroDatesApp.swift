//
//  MicroDatesApp.swift
//  MicroDates
//
//  Created by Andrey Chernoprudov on 29.11.2022.
//

import SwiftUI

@main
struct MicroDatesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            DetailsListPage()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

//
//  NSManagedContext+SaveOfCrash.swift
//  Core
//
//  Created by Andrey Chernoprudov on 06.07.2021.
//

import CoreData

public extension NSManagedObjectContext {
    func saveOrCrash() {
        do {
            try save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

//
//  NSManagedContext+SaveOfCrash.swift
//  MicroToDo
//
//  Created by Andrey Chernoprudov on 06.07.2021.
//

import CoreData

extension NSManagedObjectContext {
    func saveOrCrash() {
        do {
            try save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

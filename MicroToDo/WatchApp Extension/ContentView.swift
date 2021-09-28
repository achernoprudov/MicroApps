//
//  ContentView.swift
//  WatchApp Extension
//
//  Created by Andrey Chernoprudov on 21.07.2021.
//

import ToDoWatchCore
import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ToDo.created, ascending: false)
        ],
        predicate: NSPredicate(format: "%K = NO", #keyPath(ToDo.done)),
        animation: .default
    )
    private var todoItems: FetchedResults<ToDo>
    
    var body: some View {
        List {
            ForEach(todoItems, id: \.listIdentifier) { item in
                HStack {
                    CheckBoxView(checked: false)
                    Text(item.title)
                }
                .onTapGesture(perform: {
                    complete(item)
                })
            }
        }
        .navigationTitle("Micro ToDo")
    }
    
    private func complete(_ item: ToDo) {
        item.done = true

        viewContext.saveOrCrash()
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

//
//  ContentView.swift
//  MicroCodes
//
//  Created by Andrey Chernoprudov on 21.07.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CodeItem.creationDate, ascending: true)],
        animation: .default)
    private var items: FetchedResults<CodeItem>
    
    @State
    var addCodePresented = false

    var body: some View {
        CodesListView()
            .navigationBarItems(trailing: EditButton())
            .navigationTitle("MicroCodes")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    
                    Button {
                        addCodePresented = true
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .popover(isPresented: $addCodePresented) {
                AddCodeView { title, key in
                    addCodePresented = false
                    addItem(title: title, key: key)
                }
            }
    }

    private func addItem(title: String, key: String) {
        withAnimation {
            let newItem = CodeItem(context: viewContext)
            newItem.title = title
            newItem.creationDate = Date()
            newItem.key = Data(key.utf8).base64EncodedData()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

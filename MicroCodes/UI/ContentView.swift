//
//  ContentView.swift
//  MicroCodes
//
//  Created by Andrey Chernoprudov on 21.07.2021.
//

import SwiftUI
import CoreData
import Core

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

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
            newItem.key = base32DecodeToData(key)!
            
            viewContext.saveOrCrash()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

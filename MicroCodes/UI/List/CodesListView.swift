//
//  CodesListView.swift
//  MicroCodes
//
//  Created by Andrey Chernoprudov on 24.10.2021.
//

import SwiftUI

struct CodesListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CodeItem.creationDate, ascending: true)],
        animation: .default)
    private var items: FetchedResults<CodeItem>
    
    var body: some View {
        List {
            ForEach(items) { item in
                OTPItemView(title: item.title, secret: item.key)
                    .listRowSeparator(.hidden)
            }
            .onDelete(perform: deleteItems)
        }
        .listStyle(PlainListStyle())
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

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

struct CodesListView_Previews: PreviewProvider {
    static var previews: some View {
        CodesListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

//
//  CodesListView.swift
//  MicroCodes
//
//  Created by Andrey Chernoprudov on 24.10.2021.
//

import SwiftUI
import Core

struct CodesListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CodeItem.creationDate, ascending: true)],
        animation: .default)
    private var items: FetchedResults<CodeItem>
    
    var body: some View {
        if items.isEmpty {
            Text("You have no codes")
        } else {
            List {
                ForEach(items) { item in
                    OTPItemView(title: item.title, secret: item.key)
                        .listRowSeparator(.hidden)
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(PlainListStyle())
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            viewContext.saveOrCrash()
        }
    }
}

struct CodesListView_Previews: PreviewProvider {
    static var previews: some View {
        CodesListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

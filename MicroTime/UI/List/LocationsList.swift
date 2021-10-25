//
//  LocationsList.swift
//  MicroTime
//
//  Created by Andrey Chernoprudov on 25.10.2021.
//

import SwiftUI

struct LocationsList: View {
    
    // MARK: - Dependencies

    @Environment(\.managedObjectContext)
    private var viewContext
    
    // MARK: - Instance variables

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Location.creationDate, ascending: true)],
        animation: .default
    )
    private var items: FetchedResults<Location>
    
    @State
    private var date = Date()
    
    var body: some View {
        List {
            ForEach(items) { item in
                LocationItemView(identifier: item.timeZoneId, time: date)
            }
            .onDelete(perform: deleteItems)
        }
    }
    
    // MARK: - Private
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            viewContext.saveOrCrash()
        }
    }
}

struct LocationsList_Previews: PreviewProvider {
    static var previews: some View {
        LocationsList()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

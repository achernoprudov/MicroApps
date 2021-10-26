//
//  LocationsList.swift
//  MicroTime
//
//  Created by Andrey Chernoprudov on 25.10.2021.
//

import SwiftUI
import CoreData

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
    private var timeDelta: TimeInterval = 0
    
    private var timeBinding: Binding<CGFloat> {
        Binding<CGFloat>(
            get: { CGFloat(timeDelta) / 50 },
            set: { offset in timeDelta = TimeInterval(offset * 50) }
        )
    }
    
    var body: some View {
        List {
            ForEach(items) { item in
                LocationItemView(identifier: item.timeZoneId, timeDelta: timeDelta)
            }
            .onDelete(perform: deleteItems)
            
            Spacer()
                .frame(height: 100)
        }
        .overlay(
            TimeSliderView(offset: timeBinding)
                .frame(maxWidth: .infinity, maxHeight: 100),
            alignment: .bottom
        )
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

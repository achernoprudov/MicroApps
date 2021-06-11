//
//  ListContentView.swift
//  MicroToDo
//
//  Created by Andrey Chernoprudov on 09.06.2021.
//

import SwiftUI
import CoreData
import WidgetKit

struct ListContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ToDo.created, ascending: true)
        ],
        predicate: NSPredicate(format: "%K = NO", #keyPath(ToDo.done)),
        animation: .default
    )
    private var todoItems: FetchedResults<ToDo>
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ToDo.doneAt, ascending: false)
        ],
        predicate: NSPredicate(format: "%K = YES", #keyPath(ToDo.done)),
        animation: .default
    )
    private var completedItems: FetchedResults<ToDo>

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            List {
                Section(header: Text("ToDo")) {
                    ForEach(todoItems) { item in
                        ListItemView(item: item) {
                            toggle(item: item)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                
                if completedItems.isEmpty {
                    EmptyView()
                } else {
                    Section(header: Text("Completed")) {
                        ForEach(completedItems) { item in
                            ListItemView(item: item) {
                                toggle(item: item)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
            }
            
            Button(action: addItem) {
                Image(systemName: "plus")
                    .foregroundColor(.white)
            }
            .frame(width: 60, height: 60, alignment: .center)
            .background(
                Circle()
                    .foregroundColor(.blue)
            )
            .padding(20)
            .shadow(radius: 10)
        }
        .navigationTitle("Micro ToDo")
        .toolbar {
            EditButton()
        }
        .onDisappear {
            WidgetCenter.shared.reloadAllTimelines()
        }
    }

    private func addItem() {
        withAnimation {
            _ = ToDo(context: viewContext)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { todoItems[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func toggle(item: ToDo) {
        withAnimation {
            do {
                item.done.toggle()
                
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListContentView()
        }
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .preferredColorScheme(.dark)
    }
}

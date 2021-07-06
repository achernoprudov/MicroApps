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
    @Environment(\.managedObjectContext)
    private var viewContext

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
    
    @State
    private var editableItem: ToDo?

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            List {
                ForEach(todoItems, id: \.listIdentifier) { item in
                    HStack {
                        ListItemView(
                            item: item,
                            onChecked: { toggle(item: item) }
                        )
                        Spacer()
                    }
                    .background(
                        Rectangle()
                            .foregroundColor(Color(UIColor.systemBackground))
                    )
                    .onTapGesture {
                        editableItem = item
                    }
                }
                .onDelete(perform: deleteItems)
                
                if completedItems.isEmpty {
                    EmptyView()
                } else {
                    Section(header: Header(title: "Completed")) {
                        ForEach(completedItems, id: \.listIdentifier) { item in
                            ListItemView(
                                item: item,
                                onChecked: { toggle(item: item) }
                            )
                            .background(
                                Rectangle()
                                    .foregroundColor(Color(UIColor.systemBackground))
                            )
                            .onTapGesture {
                                editableItem = item
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
            }
            .environment(\.horizontalSizeClass, .regular)
            
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
        .popover(
            item: $editableItem,
            content: { item in
                NavigationView {
                    EditToDoView(todo: item, onClose: {
                        self.editableItem = nil
                    })
                }
            })
        .navigationTitle("Micro ToDo")
        .toolbar {
            EditButton()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification), perform: { _ in
            WidgetCenter.shared.reloadAllTimelines()
        })
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
    
    private func edit(item: ToDo) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListContentView()
        }
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//        .preferredColorScheme(.dark)
    }
}

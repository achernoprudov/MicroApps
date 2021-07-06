//
//  EditToDoView.swift
//  MicroToDo
//
//  Created by Andrey Chernoprudov on 06.07.2021.
//

import SwiftUI

struct EditToDoView: View {
    private let todo: ToDo
    private let onClose: () -> Void
    
    @State
    private var text: String
    
    @Environment(\.managedObjectContext)
    private var viewContext
    
    var body: some View {
        VStack {
            Divider()
            TextEditor(text: $text)
                .padding()
        }
        .navigationBarTitle("Edit ToDo", displayMode: .large)
        .navigationBarItems(
            leading: Button("Cancel", action: onClose),
            trailing: Button("Save", action: saveAndClose)
        )
    }
    
    init(
        todo: ToDo,
        onClose: @escaping () -> Void
    ) {
        self.todo = todo
        self.onClose = onClose
        text = todo.title
    }
    
    func saveAndClose() {
        todo.title = text
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        withAnimation {
            onClose()
        }
    }
}

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
        ZStack {
            Color.black.opacity(0.8)
                .onTapGesture(perform: onClose)
            
            VStack(alignment: .center, spacing: 8) {
                HStack {
                    Button("Cancel", action: onClose)
                    Spacer()
                    Button("Save", action: saveAndClose)
                }
                .padding(.horizontal, 4)
                
                TextEditor(text: $text)
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .padding(.top, 200)
        }
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

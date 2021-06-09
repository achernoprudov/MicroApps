//
//  NoteCardView.swift
//  MicroNotes
//
//  Created by Andrey Chernoprudov on 09.06.2021.
//

import SwiftUI

struct NoteCardView: View {
    
    private let note: Note
    
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @State
    var text: String
    
    init(note: Note) {
        self.note = note
        text = note.text
    }
    
    var body: some View {
        TextEditor(text: $text)
            .font(.body)
            .padding()
            .navigationBarTitle("", displayMode: .inline)
        .onDisappear(perform: saveNote)
    }
    
    private func saveNote() {
        note.text = text
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct NoteCardView_Previews: PreviewProvider {
    static var previews: some View {
        let notes = try! Note.fetchAll(with: PersistenceController.preview.container.viewContext)
        return NavigationView {
            NoteCardView(note: notes.first!)
        }
    }
}

//
//  NoteItemView.swift
//  MicroNotes
//
//  Created by Andrey Chernoprudov on 08.06.2021.
//

import SwiftUI
import CoreData

struct NoteItemView: View {
    
    
    let note: Note
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(note.title)
                .font(.headline)
            
            Text(note.timestamp, formatter: timestampFormatter)
                .font(.footnote)
        }
    }
}

private let timestampFormatter: RelativeDateTimeFormatter = {
    let formatter = RelativeDateTimeFormatter()
    formatter.dateTimeStyle = .named
    return formatter
}()

struct NoteItemView_Previews: PreviewProvider {
    static var previews: some View {
        let notes = try! Note.fetchAll(with: PersistenceController.preview.container.viewContext)
        
        return List {
            ForEach(notes) { note in
                NoteItemView(note: note)
            }
        }
    }
}

//
//  ListItemView.swift
//  MicroToDo
//
//  Created by Andrey Chernoprudov on 10.06.2021.
//

import SwiftUI

struct ListItemView: View {
    
    @State
    private var value: String
    
    @Environment(\.managedObjectContext)
    private var viewContext
    
    private let item: ToDo
    private let onChecked: () -> Void
    
    init(item: ToDo, onChecked: @escaping () -> Void) {
        self.item = item
        self.value = item.title
        self.onChecked = onChecked
    }
    
    var body: some View {
        VStack {
            HStack {
                CheckBoxView(checked: item.done, onChecked: onChecked)
                TextField("ToDo item", text: $value, onEditingChanged: onEditingChanged)
            }
            if let doneAt = item.doneAt {
                Text(doneAt, formatter: itemFormatter)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
    
    private func onEditingChanged(_: Bool) {
        item.title = value
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}


private let itemFormatter: RelativeDateTimeFormatter = {
    let formatter = RelativeDateTimeFormatter()
    formatter.dateTimeStyle = .named
    return formatter
}()

//
//struct ListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListItemView()
//    }
//}

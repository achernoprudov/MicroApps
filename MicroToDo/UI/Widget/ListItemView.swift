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
    private let onTap: () -> Void
    
    init(
        item: ToDo,
        onChecked: @escaping () -> Void,
        onTap: @escaping () -> Void
    ) {
        self.item = item
        self.value = item.title
        self.onChecked = onChecked
        self.onTap = onTap
    }
    
    var body: some View {
        VStack {
            HStack {
                CheckBoxView(checked: item.done, onChecked: onChecked)
                
                Text(item.title.isEmpty ? "New ToDo" : item.title)
                    .font(.body)
                    .if(item.done) { $0.strikethrough() }
                    .if(item.title.isEmpty) { $0.foregroundColor(.gray) }
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            if let doneAt = item.doneAt {
                Text(doneAt, formatter: itemFormatter)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .onTapGesture(perform: onTap)
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

//
//  ListItemView.swift
//  MicroToDo
//
//  Created by Andrey Chernoprudov on 10.06.2021.
//

import SwiftUI

struct ListItemView: View {
    
    private let item: ToDo
    
    @State
    private var value: String
    
    @Environment(\.managedObjectContext)
    private var viewContext
    
    init(item: ToDo) {
        self.item = item
        value = item.title
    }
    
    var body: some View {
        HStack {
            CheckBoxView(checked: item.done)
            TextField("ToDo item", text: $value, onEditingChanged: onEditingChanged)
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

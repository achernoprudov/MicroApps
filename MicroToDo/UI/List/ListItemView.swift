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
    private var isOn: Bool
    
    init(item: ToDo) {
        self.item = item
        isOn = item.done
    }
    
    var body: some View {
        HStack {
            Toggle(isOn: $isOn, label: {
                Text(item.title)
            })
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

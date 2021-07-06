//
//  Header.swift
//  MicroToDo
//
//  Created by Andrey Chernoprudov on 06.07.2021.
//

import SwiftUI

struct Header: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title3)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .listRowInsets(EdgeInsets())
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Header(title: "Uncompleted")
            Header(title: "Completed")
            Header(title: "✅ Done")
            Header(title: "📨 Inbox")
        }
    }
}

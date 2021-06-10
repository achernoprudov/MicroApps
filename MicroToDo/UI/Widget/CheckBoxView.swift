//
//  CheckBoxView.swift
//  MicroToDo
//
//  Created by Andrey Chernoprudov on 10.06.2021.
//

import SwiftUI

struct CheckBoxView: View {
    let checked: Bool

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            CheckBoxView(checked: true)
            CheckBoxView(checked: false)
        }
    }
}

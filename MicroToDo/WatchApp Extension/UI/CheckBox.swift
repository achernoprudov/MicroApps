//
//  CheckBox.swift
//  WatchApp Extension
//
//  Created by Andrey Chernoprudov on 29.07.2021.
//

import SwiftUI

struct CheckBoxView: View {
    let checked: Bool

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(checked ? Color.blue : Color.secondary)
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


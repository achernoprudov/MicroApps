//
//  AddCodeView.swift
//  MicroCodes
//
//  Created by Andrey Chernoprudov on 17.10.2021.
//

import SwiftUI

struct AddCodeView: View {
    
    typealias Completion = (_ title: String, _ key: String) -> Void
    
    @State
    var title: String = ""
    @State
    var key: String = ""
    
    let completion: Completion
    
    var body: some View {
        NavigationView {
            List {
                TextField("Title", text: $title)
                TextField("Key", text: $key)
                
                Button("Add") {
                    completion(title, key)
                }
            }
            .navigationTitle("Add new code")
        }
    }
}

struct AddCodeView_Previews: PreviewProvider {
    static var previews: some View {
        AddCodeView { _, _ in
            
        }
    }
}

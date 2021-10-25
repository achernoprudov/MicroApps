//
//  AddLocationView.swift
//  MicroTime
//
//  Created by Andrey Chernoprudov on 25.10.2021.
//

import SwiftUI

struct AddLocationView: View {
    
    typealias Completion = (TimeZone?) -> Void
    
    let completion: Completion
    let all: [String]
    
    init(completion: @escaping Completion) {
        self.completion = completion
        self.all = TimeZone.knownTimeZoneIdentifiers
    }
    
    var body: some View {
        NavigationView {
            List(all, id: \.self) { id in
                AddLocationItemView(identifier: id) { timeZone in
                    completion(timeZone)
                }
            }
            .navigationTitle("Add location")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        completion(nil)
                    }
                }
            }
        }
    }
}

struct AddLocationView_Previews: PreviewProvider {
    static var previews: some View {
        AddLocationView { _ in
            
        }
    }
}

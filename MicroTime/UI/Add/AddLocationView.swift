//
//  AddLocationView.swift
//  MicroTime
//
//  Created by Andrey Chernoprudov on 25.10.2021.
//

import SwiftUI

struct AddLocationView: View {
    
    typealias Completion = (TimeZone?) -> Void
    
    private let completion: Completion
    private let all: [TimeZone]
    
    @State
    private var query = ""
    
    private var displayItems: [TimeZone] {
        if query.isEmpty {
            return all
        }
        return all.filter { $0.locationName.contains(query) }
    }
    
    init(completion: @escaping Completion) {
        self.completion = completion
        self.all = TimeZone.knownTimeZoneIdentifiers
            .compactMap(TimeZone.init(identifier:))
    }
    
    var body: some View {
        NavigationView {
            List(displayItems, id: \.identifier) { timezone in
                AddLocationItemView(timezone: timezone) { timezone in
                    completion(timezone)
                }
            }
            .navigationTitle("Add location")
            .searchable(text: $query)
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

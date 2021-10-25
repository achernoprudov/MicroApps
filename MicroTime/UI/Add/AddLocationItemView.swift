//
//  AddLocationItemView.swift
//  MicroTime
//
//  Created by Andrey Chernoprudov on 25.10.2021.
//

import SwiftUI

struct AddLocationItemView: View {
    
    private let timeZone: TimeZone
    private let onTap: (TimeZone) -> Void
    
    private var title: String {
        timeZone.locationName
    }
    
    private var gmtCaption: String {
        timeZone.localizedName(for: .shortStandard, locale: .current) ?? timeZone.identifier
    }
    
    init(identifier: String, onTap: @escaping (TimeZone) -> Void) {
        self.timeZone = TimeZone(identifier: identifier)!
        self.onTap = onTap
    }
    
    var body: some View {
        HStack(alignment: .top) {
            
            Text(title)
                .font(.title2)
            
            Spacer()
            
            Text(gmtCaption)
                .font(.body)
        }
        .onTapGesture {
            onTap(timeZone)
        }
    }
}

struct AddLocationItemView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            AddLocationItemView(identifier: "Africa/Lagos") { _ in }
            AddLocationItemView(identifier: "Asia/Tokyo") { _ in }
        }
    }
}

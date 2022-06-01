//
//  AddLocationItemView.swift
//  MicroTime
//
//  Created by Andrey Chernoprudov on 25.10.2021.
//

import SwiftUI

struct AddLocationItemView: View {
    
    private let timezone: TimeZone
    private let onTap: (TimeZone) -> Void
    
    private var title: String {
        timezone.locationName
    }
    
    private var gmtCaption: String {
        timezone.localizedName(for: .shortStandard, locale: .current) ?? timezone.identifier
    }
    
    init(timezone: TimeZone, onTap: @escaping (TimeZone) -> Void) {
        self.timezone = timezone
        self.onTap = onTap
    }
    
    init(
        identifier: String,
        onTap: @escaping (TimeZone) -> Void
    ) {
        self.timezone = TimeZone(identifier: identifier)!
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
            onTap(timezone)
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

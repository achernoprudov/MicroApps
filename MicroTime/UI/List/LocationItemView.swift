//
//  LocationItemView.swift
//  MicroTime
//
//  Created by Andrey Chernoprudov on 25.10.2021.
//

import SwiftUI

struct LocationItemView: View {
    // MARK: - Instance variables
    
    private let timeZone: TimeZone
    private let formattedTime: String
    
    // MARK: - Computable
    
    private var title: String {
        timeZone.locationName
    }
    
    private var gmtCaption: String {
        timeZone.localizedName(for: .shortStandard, locale: .current) ?? timeZone.identifier
    }
    
    var body: some View {
        HStack(alignment: .top) {
            
            VStack(alignment: .leading, spacing: 10) {
            
                Text(title)
                    .font(.title2)
                    .bold()
                
                Text(gmtCaption)
                    .font(.footnote)
            }
            
            Spacer()
            
            Text(formattedTime)
        }
    }
    
    // MARK: - Public
    
    init(identifier: String, timeDelta: TimeInterval) {
        self.timeZone = TimeZone(identifier: identifier)!
        
        // FIXME: implement Flyweight pattern
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        let time = Date(timeIntervalSinceNow: timeDelta)
        self.formattedTime = dateFormatter.string(from: time)
    }
}

struct LocationItemView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            LocationItemView(identifier: "Africa/Lagos", timeDelta: 0)
            LocationItemView(identifier: "Asia/Tokyo", timeDelta: 0)
        }
    }
}

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
    private let dateFormatter: DateFormatter
    private let time: Date
    
    // MARK: - Computable
    
    private var title: String {
        timeZone.identifier.replacingOccurrences(of: "/", with: ", ")
    }
    
    private var gmtCaption: String {
        timeZone.localizedName(for: .shortStandard, locale: .current) ?? timeZone.identifier
    }
    
    var body: some View {
        HStack(alignment: .top) {
            
            VStack(alignment: .leading) {
            
                Text(title)
                    .font(.title2)
                    .bold()
                
                Text(gmtCaption)
                    .font(.footnote)
            }
            
            Spacer()
            
            Text(time, formatter: dateFormatter)
        }
    }
    
    // MARK: - Public
    
    init(identifier: String, time: Date) {
        self.timeZone = TimeZone(identifier: identifier)!
        self.time = time
        
        // FIXME: implement Flyweight pattern
        self.dateFormatter = DateFormatter()
        self.dateFormatter.timeZone = timeZone
        self.dateFormatter.dateStyle = .none
        self.dateFormatter.timeStyle = .short
    }
}

struct LocationItemView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            LocationItemView(identifier: "Africa/Lagos", time: Date())
            LocationItemView(identifier: "Asia/Tokyo", time: Date())
        }
    }
}

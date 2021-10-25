//
//  TimeZone+LocationName.swift
//  MicroTime
//
//  Created by Andrey Chernoprudov on 25.10.2021.
//

import Foundation

extension TimeZone {
    var locationName: String {
        identifier
            .replacingOccurrences(of: "/", with: ", ")
            .replacingOccurrences(of: "_", with: " ")
    }
}

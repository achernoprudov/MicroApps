//
//  AppBackground.swift
//  MicroToDo
//
//  Created by Andrey Chernoprudov on 11.06.2021.
//

import SwiftUI

struct AppBackground: View {
    @Environment(\.colorScheme)
    private var colorScheme
    
    var body: some View {
        
        if colorScheme == .light {
            Color.white
        } else {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(.displayP3, red: 44 / 255, green: 44 / 255, blue: 67 / 255, opacity: 1),
                    Color(.displayP3, red: 38 / 255, green: 38 / 255, blue: 45 / 255, opacity: 1),
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

struct AppBackground_Previews: PreviewProvider {
    static var previews: some View {
        AppBackground().preferredColorScheme(.dark)
        AppBackground().preferredColorScheme(.light)
    }
}

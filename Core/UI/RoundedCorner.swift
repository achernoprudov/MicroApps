//
//  CornerRadius.swift
//  Core
//
//  Created by Andrey Chernoprudov on 06.07.2021.
//

import SwiftUI

public extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct CornerRadius_Previews: PreviewProvider {
    static var previews: some View {
        Color.blue
            .frame(width: 100, height: 100, alignment: .center)
            .cornerRadius(25, corners: [.topLeft, .bottomRight])
    }
}

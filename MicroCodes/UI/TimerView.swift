//
//  TimerView.swift
//  MicroCodes
//
//  Created by Andrey Chernoprudov on 29.09.2021.
//

import SwiftUI

struct TimerShape: Shape {
    
    // MARK: - Static
    
    private static let strokeStyle = StrokeStyle(
        lineWidth: 4,
        lineCap: .round
    )
    
    // MARK: - Instance variables
    
    // MARK: - Public
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let size = min(rect.width, rect.height)
        
        path.addArc(
            center: center,
            radius: size,
            startAngle: .radians(.pi * 3 / 2),
            endAngle: .radians(.pi * 2),
            clockwise: true
        )
        return path.strokedPath(Self.strokeStyle)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerShape()
            .frame(width: 200, height: 130, alignment: .center)
    }
}

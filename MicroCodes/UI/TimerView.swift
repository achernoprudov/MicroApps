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
    
    private static let arcPart: Double = 0.0625
    
    // MARK: - Instance variables
    
    private let startRadians: Double = 3 * .pi / 2
    private let endAngle: Double
    
    // MARK: - Public
    
    internal init(progress: Double) {
        let parts = (progress / Self.arcPart).rounded()
        endAngle = startRadians + (2 * .pi * (parts * Self.arcPart))
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let size = min(rect.width, rect.height)
        
        path.addArc(
            center: center,
            radius: size,
            startAngle: .radians(endAngle),
            endAngle: .radians(startRadians),
            clockwise: true
        )
        return path.strokedPath(Self.strokeStyle)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TimerShape(progress: 0.1)
                .frame(width: 50, height: 100, alignment: .center)
            
            TimerShape(progress: 0.25)
                .frame(width: 50, height: 100, alignment: .center)
            
            TimerShape(progress: 0.5)
                .frame(width: 50, height: 150, alignment: .center)
    
            TimerShape(progress: 0.9)
                .frame(width: 50, height: 100, alignment: .center)
        }
    }
}

//
//  TimeSliderView.swift
//  MicroTime
//
//  Created by Andrey Chernoprudov on 25.10.2021.
//

import SwiftUI

struct TimeSliderView: View {
    
    private static let step: CGFloat = 60
    
    @State
    var startOffset: CGFloat = 0
    @Binding
    var offset: CGFloat
    @State
    var scaleMultiplier: CGFloat = 1
    
    var body: some View {
        TimeScaleShape(offset: offset, scaleMultiplier: scaleMultiplier)
            .background(Color.white.opacity(0.0001))
            .mask(
                LinearGradient(
                    colors: [Color.clear, Color.white, Color.clear],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .gesture(
                DragGesture()
                    .onChanged { value in
                        offset = startOffset + value.translation.width
                        scaleMultiplier = 1 + min(abs(value.translation.height), 200) / 100
                    }
                    .onEnded { value in
                        let newValue = startOffset + value.predictedEndTranslation.width
                        withAnimation(.spring()) {
                            startOffset = newValue
                            offset = newValue
                            scaleMultiplier = 1
                        }
                    }
            )
    }
}

struct TimeScaleShape: Shape {
    
    private static let linesNumber: CGFloat = 30
    
    private static let strokeStyle = StrokeStyle(
        lineWidth: 4,
        lineCap: .round
    )
    
    var offset: CGFloat
    var scaleMultiplier: CGFloat
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(offset, scaleMultiplier) }
        set {
            offset = newValue.first
            scaleMultiplier = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let centerLineX = calcCenterLineX(from: rect)
        path.move(to: CGPoint(x: centerLineX, y: 0))
        path.addLine(to: CGPoint(x: centerLineX, y: rect.height))
        path.closeSubpath()

        let step = (rect.width / Self.linesNumber) * scaleMultiplier
        var x = centerLineX
        var i = 0
        // lines at left
        while x > 0 {
            x -= step
            i += 1
            let y = (i % 5 == 0) ? 0 : rect.height / 3 * 2
            
            path.move(to: CGPoint(x: x, y: y))
            path.addLine(to: CGPoint(x: x, y: rect.maxY))
            path.closeSubpath()
        }
        
        // lines at right
        x = centerLineX
        i = 0
        while x < rect.width {
            x += step
            i += 1
            let y = (i % 5 == 0) ? 0 : rect.height / 3 * 2
            
            path.move(to: CGPoint(x: x, y: y))
            path.addLine(to: CGPoint(x: x, y: rect.maxY))
            path.closeSubpath()
        }
        
        return path
            .strokedPath(Self.strokeStyle)
    }
    
    private func calcCenterLineX(from rect: CGRect) -> CGFloat {
        var centerLineX = rect.midX + offset
        centerLineX.formTruncatingRemainder(dividingBy: rect.width)
        if centerLineX < 0 {
            centerLineX = rect.width + centerLineX
        }
        return centerLineX
    }
}

struct TimeSliderView_Previews: PreviewProvider {
    struct Wrapper: View {
        static let formatter: DateFormatter = {
            let f = DateFormatter()
            f.dateStyle = .short
            f.timeStyle = .short
            return f
        }()
        
        @State
        var value: CGFloat = 0
        
        var body: some View {
            VStack {
                TimeSliderView(offset: Binding(
                    get: { return value / 10 },
                    set: { newValue in value = newValue * 10 }
                ))
                .background(Color.gray)
                
                Text(Date(timeIntervalSinceNow: TimeInterval(value)), formatter: Self.formatter)
                
                Text("Offset: \(value)")
            }
        }
    }
    
    static var previews: some View {
        Wrapper()
            .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 100)
            
    }
}

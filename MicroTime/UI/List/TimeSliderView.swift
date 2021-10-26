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
    
    var body: some View {
        Color.gray
            .overlay(TimeScaleShape(offset: offset))
//            .overlay(CircleView(xOffset: offset))
            .gesture(
                DragGesture()
                    .onChanged { value in
                        offset = startOffset + value.translation.width
                    }
                    .onEnded { value in
                        let newValue = startOffset + value.predictedEndTranslation.width
                        withAnimation(.spring()) {
                            startOffset = newValue
                            offset = newValue
                        }
                    }
            )
    }
}
struct TimeScaleShape: Shape {
    private static let strokeStyle = StrokeStyle(
        lineWidth: 4,
        lineCap: .round
    )
    
    var offset: CGFloat
    
    var animatableData: CGFloat {
        get { return offset }
        set { offset = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        var x = rect.midX + offset
        x.formTruncatingRemainder(dividingBy: rect.width)
        if x < 0 {
            x = rect.width + x
        }
        
        path.move(to: CGPoint(x: x, y: 0))
        path.addLine(to: CGPoint(x: x, y: rect.height))
        
        return path
            .strokedPath(Self.strokeStyle)
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
                TimeSliderView(offset: $value)
                    .background(Color.gray)
                
                Text(Date(timeIntervalSinceNow: TimeInterval(value)), formatter: Self.formatter)
                
                Text("Offset: \(value)")
            }
        }
    }
    
    static var previews: some View {
        Wrapper()
            .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
            
    }
}

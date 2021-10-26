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
            .overlay(CircleView(xOffset: offset))
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

// FIXME: Replace with dashes
struct CircleView: View {
    let xOffset: CGFloat
    
    var body: some View {
        GeometryReader { g in
            Rectangle()
                .foregroundColor(.black)
                .frame(width: 10, height: 10)
                .offset(x: calcOffset(for: g), y: 20)
        }
    }
    
    func calcOffset(for geometry: GeometryProxy) -> CGFloat {
        let result = xOffset.truncatingRemainder(dividingBy: geometry.size.width)
        if result > 0 {
            return result
        }
        return geometry.size.width + result
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

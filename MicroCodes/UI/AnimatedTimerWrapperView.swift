//
//  AnimatedTimerWrapperView.swift
//  MicroCodes
//
//  Created by Andrey Chernoprudov on 19.10.2021.
//

import SwiftUI

struct AnimatedTimerWrapperView: View {
    @State
    private var progress: Double = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        TimerShape(progress: progress)
            .onReceive(timer) { sec in
                let secs = Int(sec.timeIntervalSince1970) % 30
                progress = 1 - Double(secs) / 30
            }
    }
}

struct ContentView2: View {
    @State var timeRemaining = 10
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Text("\(timeRemaining)")
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                }
            }
    }
}

struct AnimatedTimerWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedTimerWrapperView()
            .frame(width: 100, height: 100, alignment: .center)
    }
}
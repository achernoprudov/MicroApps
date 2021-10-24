//
//  OTPItemView.swift
//  MicroCodes
//
//  Created by Andrey Chernoprudov on 24.10.2021.
//

import SwiftUI

struct OTPItemView: View {
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private let title: String
    private let totp: TOTP
    
    @State
    var code: String
    @State
    var counter: Int = 0
    
    init(title: String, secret: Data) {
        self.title = title
        self.totp = TOTP(secret: secret)!
        self.code = totp.generate(time: Date())!
    }
    
    var body: some View {
        CodeItemView(code: code, title: title)
            .onReceive(timer) { date in
                let counterValue = Int(date.timeIntervalSince1970 / 30)
                guard counterValue != counter else { return }
                self.counter = counterValue
                self.code = totp.generate(time: Date())!
            }
    }
}

struct OTPItemView_Previews: PreviewProvider {
    static var previews: some View {
        OTPItemView(title: "Google", secret: Data())
    }
}

//
//  CodeItemView.swift
//  MicroCodes
//
//  Created by Andrey Chernoprudov on 28.09.2021.
//

import SwiftUI

struct CodeItemView: View {
    
    let code: String
    let title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(code)
                .font(Font.title)
                .foregroundColor(.white)
                .bold()
            
            Text(title)
                .foregroundColor(.white)
                .font(Font.body)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(alignment: .bottomTrailing) {
            AnimatedTimerWrapperView()
                .foregroundColor(.white)
                .frame(width: 10, height: 10, alignment: .center)
                .padding(20)
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 146/255, green: 114/255, blue: 219/255),
                    Color(red: 90/255, green: 71/255, blue: 135/255),
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 0)
        .padding(.vertical, 10)
    }
}

struct CodeItemView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            CodeItemView(code: "131 113", title: "Amazon")
                .listRowSeparator(.hidden)
            
            CodeItemView(code: "811 001", title: "Github")
                .listRowSeparator(.hidden)
            
            CodeItemView(code: "082 721", title: "Google")
                .listRowSeparator(.hidden)
            
        }
        .listStyle(PlainListStyle())
    }
}

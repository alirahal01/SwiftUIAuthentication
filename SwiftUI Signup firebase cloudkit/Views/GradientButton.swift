//
//  GradientButton.swift
//  SwiftUI Signup firebase cloudkit
//
//  Created by ali rahal on 17/06/2024.
//

import SwiftUI

struct GradientButton: View {
    
    @State private var angle = 0.0
    
    var gradient1: [Color] = [
        Color.init(red: 101/255, green: 134/255, blue: 1),
        Color.init(red: 1, green: 64/255, blue: 80/255),
        Color.init(red: 109/255, green: 1, blue: 185/255),
        Color.init(red: 39/255, green: 232/255, blue: 1)
    ]
    
    var buttonTitle: String
    var buttonAction: () -> Void
    
    var body: some View {
        Button (action: buttonAction, label: {
            GeometryReader() { geometry in
                ZStack {
                    AngularGradient(gradient: Gradient(colors: gradient1), center: .center, angle: .degrees(angle))
                        .blur(radius: 8)
                        .mask(
                            RoundedRectangle(cornerRadius: 16.0)
                                .frame(height: 50)
                                .frame(maxWidth: geometry.size.width - 16)
                                .blur(radius: 8)
                        )
                        .onAppear() {
                            withAnimation(.linear(duration: 7)) {
                                self.angle += 350
                            }
                        }
                    GradientText(text: buttonTitle)
                        .font(.headline)
                        .frame(width: geometry.size.width - 16)
                        .frame(height: 50)
                        .background(
                            Color("tertiaryBackground")
                                .opacity(0.9)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16.0)
                                .stroke(Color.white, lineWidth: 1.9)
                                .blendMode(.normal)
                                .opacity(0.7)
                        )
                        .cornerRadius(16.0)
                }
            }
            .frame(height: 50)
        })
    }
}

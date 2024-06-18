//
//  TextFieldIcon.swift
//  SwiftUI Signup firebase cloudkit
//
//  Created by ali rahal on 17/06/2024.
//

import SwiftUI

struct TextFieldIcon: View {
    var iconName: String
    @Binding var currentlyEditing: Bool
    @State private var colorAngle: Double = 0.0
    
    var gradient1: [Color] = [
        Color.init(red: 101/255, green: 134/255, blue: 1),
        Color.init(red: 1, green: 64/255, blue: 80/255),
        Color.init(red: 109/255, green: 1, blue: 185/255),
        Color.init(red: 39/255, green: 232/255, blue: 1)
    ]
    
    var body: some View {
        ZStack {
            VisualEffectBlur(blurStyle: .dark) {
                ZStack {
                    if currentlyEditing {
                        AngularGradient(gradient: Gradient(colors: gradient1), center: .center,angle: .degrees(self.colorAngle))
                            .blur(radius: 10.0)
                            .onAppear() {
                                withAnimation(.linear(duration: 7.0)) {
                                    self.colorAngle += 350
                                }
                            }
                    }
                    Color("terrtiaryBackground")
                        .cornerRadius(12)
                        .opacity(0.8)
                    .blur(radius: 3.0)
                }
            }
        }
        .cornerRadius(12)
        .overlay(
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white, lineWidth: 1)
                    .blendMode(.overlay)
                
                Image(systemName: iconName)
                    .gradientForeground(colors: [Color("pink-gradient-1"),Color("pink-gradient-2")])
                    .font(.system(size: 17,weight: .medium))
                
                
            }
        )
        .frame(width: 36, height: 36, alignment: .center)
        .padding([.vertical,.leading], 8)
    }
}

#Preview {
    TextFieldIcon(iconName: "key.fill", currentlyEditing: .constant(false))
}

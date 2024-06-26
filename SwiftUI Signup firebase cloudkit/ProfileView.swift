//
//  ProfileView.swift
//  SwiftUI Signup firebase cloudkit
//
//  Created by ali rahal on 19/06/2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            Image("background-2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .foregroundColor(Color("pink-gradient-1"))
                                .frame(width: 66, height: 66, alignment: .center)
                            Image(systemName: "person.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 24, weight: .medium, design: .rounded))
                        }
                        .frame(width: 66, height: 66, alignment: .center)
                        
                        VStack(alignment: .leading) {
                            Text("Sai Kambampati")
                                .foregroundColor(.white)
                                .font(.title2)
                                .bold()
                            Text("View Profile")
                                .foregroundColor(.white.opacity(0.7))
                                .font(.footnote)
                        }
                        
                        Spacer()
                        
                        Button {
                            print("Segue to settings")
                        } label: {
                            TextFieldIcon(iconName: "gearshape.fill", currentlyEditing: .constant(true))
                        }

                    }
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white.opacity(0.1))
                    
                    Text("Instructor at design+Code")
                        .foregroundColor(.white)
                        .font(.title2.bold())
                    
                    Label( "asdfasdfasdf",systemImage: "calendar")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.footnote)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white.opacity(0.1))
                    
                    HStack(spacing: 16) {
                        Image("Twitter")
                            .resizable()
                            .foregroundColor(.white.opacity(0.7))
                            .frame(width: 25,height: 25, alignment: .center)
                        Image(systemName: "link")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                        Text("designcode.io")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.footnote)

                    }
                }
                .padding(16)
                
                GradientButton(buttonTitle: "Purchase Lifetime Pro Plan") {
                    print("IAP")
                }
                .padding(.horizontal, 16)
                
                Button {
                    print("restore")
                } label: {
                    GradientText(text: "Restore Purchases")
                        .font(.footnote.bold())
                }
                .padding(.bottom)
            }
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white.opacity(0.2))
                    .background(Color("secondaryBackground").opacity(0.5))
                    .background(VisualEffectBlur(blurStyle: .dark))
                    .shadow(color: Color("shadowColor").opacity(0.5), radius: 60, x: 0, y: 30)
            )
            .cornerRadius(30)
            .padding(.horizontal)
            
            VStack {
                Spacer()
                Button {
                    print("Sign out")
                } label: {
                    Image(systemName: "arrow.turn.up.forward.iphone.fill")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 0.0, y: 0.0, z: 1.0))
                    
                        .background(
                            Circle()
                                .stroke(
                                    Color.white.opacity(0.2),
                                    lineWidth: 1
                                )
                                .frame(width: 42, height: 42, alignment: .center)
                                .overlay(
                                    VisualEffectBlur(blurStyle: .dark)
                                        .cornerRadius(21)
                                        .frame(width: 42, height: 24, alignment: .center)
                                    )
                                )}
            }
            .padding(.bottom, 64)
        }
        .colorScheme(.light)
    }
}

#Preview {
    ProfileView()
}

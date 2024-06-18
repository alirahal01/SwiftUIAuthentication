//
//  ContentView.swift
//  SwiftUI Signup firebase cloudkit
//
//  Created by ali rahal on 14/06/2024.
//

import SwiftUI
import AudioToolbox

struct ContentView: View {

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var editingEmailTextField: Bool = false
    @State private var editingPasswordTextField: Bool = false
    @State private var emailIconBounce: Bool = false
    @State private var passwordIconBounce: Bool = false
    
    private let generator = UISelectionFeedbackGenerator()
    
    var body: some View {
        ZStack {
            Image("background-3")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Sign up")
                        .font(Font.largeTitle.bold())
                        .foregroundColor(.white)
                    Text("Access to 120+ hours of courses , turtorials amd live streams")
                        .font(.subheadline)
                        .foregroundColor(Color.white.opacity(0.7))
                    HStack(spacing: 12.0) {
                        TextFieldIcon(iconName: "envelope.open.fill", currentlyEditing: $editingEmailTextField)
                            .scaleEffect(emailIconBounce ? 1.2 : 1.0)
                        TextField("Email", text: $email) { isEditing in
                            editingEmailTextField = isEditing
                            editingPasswordTextField = false
                            generator.selectionChanged()
                            
                            if isEditing {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                                    emailIconBounce.toggle()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                                        emailIconBounce.toggle()
                                    }
                                })
                            }
                        }
                            .colorScheme(.dark)
                            .foregroundColor(.white.opacity(0.7))
                            .autocapitalization(.none)
                            .textContentType(.emailAddress)
                    }
                    .frame(height: 52)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white, lineWidth: 1.0)
                            .blendMode(.overlay)
                    )
                    .background(
                        Color("secondaryBackground")
                            .cornerRadius(16.0)
                            .opacity(0.8)
                    )
                    HStack(spacing: 12.0) {
                        TextFieldIcon(iconName: "key.fill", currentlyEditing: $editingPasswordTextField)
                            .scaleEffect(passwordIconBounce ? 1.2 : 1.0)
                        SecureField("Password", text: $password)
                            .colorScheme(.dark)
                            .foregroundColor(.white.opacity(0.7))
                            .autocapitalization(.none)
                            .textContentType(.emailAddress)
                    }
                    .frame(height: 52)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white, lineWidth: 1.0)
                            .blendMode(.overlay)
                    )
                    .background(
                        Color("secondaryBackground")
                            .cornerRadius(16.0)
                            .opacity(0.8)
                    )
                    .onTapGesture {
                        editingPasswordTextField = true
                        editingEmailTextField = false
                        generator.selectionChanged()
                        if editingPasswordTextField {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                                passwordIconBounce.toggle()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                                    passwordIconBounce.toggle()
                                }
                            })
                        }
                    }
                    GradientButton()
                    Text("By clicking on sign up, you agree to our terms of service and privacy policy")
                        .font(.footnote)
                        .foregroundColor(Color.white.opacity(0.7))
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.white.opacity(0.1))
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Button {
                            print("Switch to sign in")
                        } label: {
                            Text("Already have an account")
                                .font(.footnote)
                                .foregroundColor(.white)
                                .opacity(0.7)
                            GradientText(text: "Sign In")
                                .font(Font.footnote.bold())
                        }

                    }
                    
                }
                .padding(20)
            }
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(.white.opacity(0.2))
                    .background(Color("secondaryBackground")
                        .background(VisualEffectBlur(blurStyle: .systemMaterialDark))
                        .shadow(color: Color("shadowColor").opacity(0.5), radius: 60, x: 0, y: 30)
                        .opacity(0.5))
            )
            .cornerRadius(30.0)
            .padding(.horizontal)
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

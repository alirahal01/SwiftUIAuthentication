//
//  ContentView.swift
//  SwiftUI Signup firebase cloudkit
//
//  Created by ali rahal on 14/06/2024.
//

import SwiftUI
import AudioToolbox
import FirebaseAuth

struct SignupView: View {

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var editingEmailTextField: Bool = false
    @State private var editingPasswordTextField: Bool = false
    @State private var emailIconBounce: Bool = false
    @State private var passwordIconBounce: Bool = false
    
    @State private var showProfileView: Bool = false
    @State private var signUpToggle: Bool = true
    
    @State private var rotationAngle = 0.0
    @State private var fadeToggle: Bool = true
    
    @State private var showAlertView: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    private let generator = UISelectionFeedbackGenerator()
    
    var body: some View {
        ZStack {
            Image(signUpToggle ? "background-3" : "background-1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .opacity(fadeToggle ? 1.0 : 0.0)
            Color("secondaryBackground")
                .edgesIgnoringSafeArea(.all)
                .opacity(fadeToggle ? 0.0 : 1.0)
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text(signUpToggle ? "Sign up" : "Sign in")
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
                    GradientButton(buttonTitle: signUpToggle ? "Create account" : "Sign in", buttonAction: {
                        generator.selectionChanged()
                        self.signup()
                    })
                    .onAppear {
                        Auth.auth().addStateDidChangeListener {
                            auth, user in
                            if user != nil {
                                showProfileView.toggle()
                            }
                        }
                    }
                    if signUpToggle
                    {
                        Text("By clicking on sign up, you agree to our terms of service and privacy policy")
                            .font(.footnote)
                            .foregroundColor(Color.white.opacity(0.7))
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.white.opacity(0.1))
                        
                    }
                    VStack(alignment: .leading, spacing: 16) {
                        Button {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                fadeToggle.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        self.fadeToggle.toggle()
                                    }
                                }
                            }
                            withAnimation(.easeInOut(duration: 0.7)) {
                                signUpToggle.toggle()
                                self.rotationAngle += 180
                            }
                        } label: {
                            Text(signUpToggle ? "Already have an account" : "Don't have an account")
                                .font(.footnote)
                                .foregroundColor(.white)
                                .opacity(0.7)
                            GradientText(text: signUpToggle ? "Sign In" : "Sign up")
                                .font(Font.footnote.bold())
                        }
                    }
                    
                    if !signUpToggle {
                        Button {
                            self.sendPasswordResetEmail()
                        } label: {
                            HStack(spacing: 4) {
                                Text("Forgot password")
                                    .font(.footnote)
                                    .foregroundColor(.white.opacity(0.7))
                                    GradientText(text: "Reset password")
                                    .font(.footnote)
                                    .bold()
                            }
                        }

                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.white)
                            .opacity(0.1)
                        
                        Button {
                            print("Sign in with apple")
                        } label: {
                            SignInWithAppleButton()
                                .frame(height: 50)
                                .cornerRadius(16)
                            
                        }

                    }
                }
                .padding(20)
            }
            .rotation3DEffect(
                Angle(degrees: self.rotationAngle),
                                      axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .alert(isPresented: $showAlertView){
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .cancel())
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
            .rotation3DEffect(
                Angle(degrees: self.rotationAngle),
                                      axis: (x: 0.0, y: 1.0, z: 0.0)
            )
        }
//        .fullScreenCover(isPresented: $showProfileView) {
//            ProfileView()
//        }
    }
    func signup() {
        if signUpToggle {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                guard error == nil else {
                    self.alertTitle = "Uh-oh!"
                    self.alertMessage = error!.localizedDescription
                    self.showAlertView.toggle()
                    return
                }
                print("user signed up")
            }
        } else {
            Auth.auth().signIn(withEmail: email, password: password) {
                result, error in
                guard error == nil else {
                    alertMessage = error!.localizedDescription
                    alertTitle = "Uh-oh!"
                    self.showAlertView.toggle()
                    return
                }
                print("user is signed in")
            }
        }
    }
    
    func sendPasswordResetEmail() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            guard error == nil else { alertMessage = error!.localizedDescription
                alertTitle = "Uh-oh!"
                self.showAlertView.toggle()
                return
            }
            self.alertTitle = "Password reset email sent"
            self.alertMessage = "Check your inbox for an email to reset your password"
            self.showAlertView.toggle()
            
        }
    }
}

#Preview {
    SignupView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

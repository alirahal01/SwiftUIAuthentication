//
//  SwiftUI_Signup_firebase_cloudkitApp.swift
//  SwiftUI Signup firebase cloudkit
//
//  Created by ali rahal on 14/06/2024.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

@main
struct SwiftUI_Signup_firebase_cloudkitApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            SignupView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

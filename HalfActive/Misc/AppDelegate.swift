//
//  AppDelegate.swift
//  HalfActive
//
//  Created by Siddharth S on 08/05/25.
//

import Foundation
import Firebase
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            executeSetupFunctions()
            return true
        }
    
    private func executeSetupFunctions() {
        FirebaseApp.configure()
    }
}


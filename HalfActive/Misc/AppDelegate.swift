//
//  AppDelegate.swift
//  HalfActive
//
//  Created by Siddharth S on 08/05/25.
//

import Foundation
import Firebase
import FirebaseAuth
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
    var notificationHandler: NotificationHandler?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            executeSetupFunctions()
        
            application.registerForRemoteNotifications()
        
        
            return true
        }
    
    private func executeSetupFunctions() {
        FirebaseApp.configure()
        
        let container = AppContainer.shared.container

        notificationHandler = container.resolve(NotificationHandler.self)

        let center = UNUserNotificationCenter.current()
        center.delegate = notificationHandler
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification auth error: \(error)")
            }
        }
    }
}


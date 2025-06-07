//
//  HalfActiveApp.swift
//  HalfActive
//
//  Created by Siddharth S on 07/05/25.
//

import SwiftUI

@main
struct ConCurrencyApp: App {
    @StateObject var coordinator = AppCoordinator()
    @StateObject private var pricesRepository = ExcercisesRepo()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // Main Window for the app
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.navigationPath) {
                OnboardingView()
                    .environmentObject(coordinator)
                    .environmentObject(pricesRepository)
                    .navigationDestination(for: Destination.self) { destination in
                        switch destination {
                        case .detail(let text):
                            DetailView(details: text)
                                .environmentObject(coordinator)
                        case .settings:
                            DetailView(details: "text")
                                .environmentObject(coordinator)
                                .environmentObject(pricesRepository)
                        }
                    }
                    .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
            }
        }
    }
}

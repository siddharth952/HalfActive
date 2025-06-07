//
//  AppCoordinator.swift
//  ConCurrency
//
//  Created by Siddharth S on 23/02/25.
//

import Foundation
import SwiftUI

protocol Coordinator: ObservableObject {
    var navigationPath: NavigationPath { get set }
    func navigate(to destination: Destination)
    func pop()
}

enum Destination: Hashable {
    case detail(String)
    case settings
}

// Coordinator for MVVM+Coordinator pattern holds navigationPath and changes navigation accordingly
class AppCoordinator: Coordinator {
    @Published var navigationPath: NavigationPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navigationPath.append(destination)
    }
    
    func pop() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }
}

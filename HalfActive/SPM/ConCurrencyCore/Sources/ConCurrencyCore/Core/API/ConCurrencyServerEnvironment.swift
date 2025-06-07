//
//  ConService.swift
//  ConCurrency
//
//  Created by Siddharth S on 21/02/25.
//

import Network
import UIKit

// Defines separate debug and prod env. variables
public enum ConCurrencyServerEnvironment: String, Codable, Hashable {
    public static var activeCase: Self {
        #if DEBUG
            return .debug
        #else
            return .production
        #endif
    }
    
    case debug
    case production
    
    // Used for build versioning
    public var appVersion: Int {
        #if DEBUG
            return 1
        #else
            return 1
        #endif
    }
}

extension ConCurrencyServerEnvironment {
    public var baseURL: URL? {
        switch self {
            case .debug:
                URL(string: self.baseURLString)
            case .production:
                URL(string: self.baseURLString)
        }
    }
    
    public var baseURLString: String {
        switch self {
            case .debug:
                return "https://openexchangerates.org/api/"
            case .production:
                return "https://openexchangerates.org/api/"
        }
    }

}

extension ConCurrencyServerEnvironment {
    private var keychainKey: String {
        // Unique Key as per the environment
        return "openexchangeAppID_\(self.rawValue)"
    }
    
    // App ID fetch from keychain to be used to with OpenExchange API
    public var openexchangeAppID: String {
        if let storedKey = KeychainHelper.shared.read(forKey: keychainKey) {
            return storedKey
        } else {
            let defaultKey = "9c9f7f8ff64b4b83baba9a09d3313842" //  App ID Key <app_id> Please replace with your own app_id this is added for testing purpose only
            KeychainHelper.shared.save(defaultKey, forKey: keychainKey)
            return defaultKey
        }
    }
}

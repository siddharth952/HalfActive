//
//  NetworkService.swift
//  DoIt
//
//  Created by Siddharth S on 12/02/25.
//

import Foundation
import Combine

// NetworkService with API endpoints with default json decoder
public class NetworkService {
    enum APIEndpoints: String {
        case latestExchange = "latest.json"
    }
    
    public static let shared = NetworkService()
    
    var isDeviceOffline: Bool = false
    public let decoder = JSONDecoder()
    
    // MARK: Repository
    public func getLatestExcercises() -> AnyPublisher<ExcerciseSection ,Error> {
        let appId = ConCurrencyServerEnvironment.activeCase.openexchangeAppID
        guard !appId.isEmpty else {
            return Fail(error: NetworkError.failed).eraseToAnyPublisher()
        }
        
        return NetworkManager.shared.getJsonContents(from: ConCurrencyServerEnvironment.activeCase.baseURLString + APIEndpoints.latestExchange.rawValue, type: ExcerciseSection.self, decoder: decoder, queryParams: ["app_id": appId])
    }
    
    
}

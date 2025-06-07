//
//  NetworkManager.swift
//  DoIt
//
//  Created by Siddharth S on 12/02/25.
//

import Foundation
import Combine

public enum NetworkError: Error {
    case failed
}

public enum HttpMethod: String {
    case get
    case post
}

// Generic NetworkManager for network calls
final class NetworkManager {
    private init() {}
    static let shared = NetworkManager()
    
    let urlSession = URLSession(configuration: .default)
    
    func getJsonContents<T: Decodable>(
        from urlString: String,
        type: T.Type,
        decoder: JSONDecoder,
        queryParams: [String: String] = [:]
    ) -> AnyPublisher<T, Error> {
        
        guard var urlComponents = URLComponents(string: urlString) else {
            return Fail(error: NetworkError.failed)
                .eraseToAnyPublisher()
        }
        
        // Add query parameters to the URL
        if !queryParams.isEmpty {
            urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        
        guard let url = urlComponents.url else {
            return Fail(error: NetworkError.failed)
                .eraseToAnyPublisher()
        }
        
        let urlSession = URLSession.shared
        
        return urlSession.dataTaskPublisher(for: url)
            .tryMap { (data: Data, response: URLResponse) in
                guard let res = response as? HTTPURLResponse, (200...299).contains(res.statusCode) else {
                    throw NetworkError.failed
                }
                print("Fetching data from:", url)
                return try decoder.decode(type, from: data)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

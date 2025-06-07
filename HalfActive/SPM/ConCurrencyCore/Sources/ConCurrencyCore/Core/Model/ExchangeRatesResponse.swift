//
//  Latest.swift
//  ConCurrency
//
//  Created by Siddharth S on 21/02/25.
//

import Foundation

public struct ExchangeRatesResponse: Codable {
    public let disclaimer: String
    public let license: String
    public let timestamp: Int
    public let base: String
    public let rates: [String: Double]
}


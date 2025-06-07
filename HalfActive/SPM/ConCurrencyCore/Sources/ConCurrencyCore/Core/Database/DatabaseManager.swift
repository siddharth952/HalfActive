//
//  DatabaseManager.swift
//  ConCurrency
//
//  Created by Siddharth S on 22/02/25.
//

import Foundation
import GRDB
import Combine


public struct CurrencyData: Codable, FetchableRecord, PersistableRecord {
    public var rates: [String: Double]
    public var timestamp: Int
    
    public init(rates: [String : Double], timestamp: Int) {
        self.rates = rates
        self.timestamp = timestamp
    }
}

public enum DatabaseManagerError: Error {
    case dbSetupFailed
    case failedToFetch
    case neverFetched
    case others
}

// GRDB SQLite Database manager for fetching, storing and deleting data on table
public class DatabaseManager {
    public static let shared = DatabaseManager()
    private var dbQueue: DatabaseQueue?
    
    public init(with tableName: String = "currency_rates") {
        try? setupDatabase(with: tableName)
    }
    
    // Setup
    private func setupDatabase(with tableName: String) throws {
        do {
            let fileManager = FileManager.default
            let dbPath = fileManager
                .urls(for: .documentDirectory, in: .userDomainMask)
                .first!
                .appendingPathComponent("currency.sqlite")
                .path
            
            dbQueue = try DatabaseQueue(path: dbPath)
            try dbQueue?.write { db in
                try db.create(table: tableName, ifNotExists: true) { t in
                    t.column("currency", .text).primaryKey()
                    t.column("rate", .double)
                    t.column("timestamp", .integer)
                }
            }
        } catch {
            print("Failed to initialize database: \(error)")
            throw DatabaseManagerError.dbSetupFailed
        }
    }
    
    // Delete all entries in table
    public func deleteTable(with tableName: String) {
        do {
            try dbQueue?.write { db in
                try db.execute(sql: "DELETE FROM \(tableName.uppercased())")
            }
        } catch {
            print("Failed to delete from table: \(error)")
        }
    }
    
    
    public func saveRates(_ rates: [String: Double], timestamp: Int) {
        //Write to the db we make sure writes are serialized
        do {
            try self.dbQueue?.write { db in
                for (currency, rate) in rates {
                    try db.execute(sql: "INSERT OR REPLACE INTO currency_rates (currency, rate, timestamp) VALUES (?, ?, ?)", arguments: [currency, rate, timestamp])
                }
            }
        } catch {
            print("Failed to save rates: \(error)")
        }
    }
    
    // load entries 
    public func loadRates() -> AnyPublisher<CurrencyData, DatabaseManagerError> {
        // loads are on concurrent queue internally
        return Future { [weak self] promise in
            // Parallel Rea/Concurrent reads possible
            var currencyData = CurrencyData(rates: [:], timestamp: -1)
            
            do {
                try self?.dbQueue?.read { db in
                    let rows = try Row.fetchAll(db, sql: "SELECT * FROM currency_rates")
                    
                    for row in rows {
                        if let currency = row["currency"] as? String,
                           let rate = row["rate"] as? Double {
                            currencyData.rates[currency] = rate
                        }
                        if let fetchedTimeStamp = row["timestamp"] as? Int64 {
                            currencyData.timestamp = Int(fetchedTimeStamp) // Int64 to Int
                        }
                    }
                }
                promise(.success(currencyData))
            } catch {
                print("Failed to load rates: \(error)")
                promise(.failure(.failedToFetch))
            }
        }
        .eraseToAnyPublisher()
    }
}

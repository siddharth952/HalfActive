//
//  PricesRepository.swift
//  ConCurrency
//
//  Created by Siddharth S on 22/02/25.
//

import Combine
import GRDB
import Foundation
import ConCurrencyCore
import SwiftUI

protocol ExercisesRepositoryProtocol {
    var latestSection: ExcerciseSection? { get }
    var isLoading: Bool { get }
}

public enum PricesRepositoryError: Error {
    case failedToFetch
}


public class ExcercisesRepo: ObservableObject, ExercisesRepositoryProtocol {
    @Published var latestSection: ExcerciseSection? = nil
    @Published var isLoading: Bool = false
    
    @Published var failure: PricesRepositoryError? = nil
    
    
    var cancellable: AnyCancellable? = nil
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        //fetch from api if data is stale(ie older than 30 mins) else we fetch from db
        //getLatestRatesAndSetModel()
    }
    
    //MARK: Private Methods
    
    // Fetch exchange rates from API and cache in SQLite
//    public func fetchRatesFromAPI() -> AnyPublisher<CurrencyData, PricesRepositoryError> {
//        // To avoid SwiftUI animation issues with NavigationStack
//        DispatchQueue.main.asyncAfter(deadline: .now()) {
//            self.isLoading = true
//        }
//        
//        return NetworkService.shared.getLatestExcercises()
//            .tryMap { response -> ExcerciseSection in
//                guard let rates = response.rates as? [String:Double] else {
//                    self.isLoading = false
//                    throw NetworkError.failed
//                }
//                DatabaseManager.shared.saveRates(response.rates, timestamp: Int(Date().timeIntervalSince1970))
//                DispatchQueue.main.asyncAfter(deadline: .now()) {
//                    withAnimation {
//                        self.isLoading = false
//                    }
//                }
//                
//                return CurrencyData(rates: rates, timestamp: Int(Date().timeIntervalSince1970))
//            }
//            .mapError({ error in
//                // Not needed with tryMap but we can use this to perform any checks on error
//                withAnimation {
//                    self.isLoading = false
//                }
//                
//                return PricesRepositoryError.failedToFetch
//            })
//            .eraseToAnyPublisher()
//    }
  
//    // Fetch exchange rates from cache
//    public func fetchRatesFromDB() -> AnyPublisher<CurrencyData, PricesRepositoryError> {
//        return DatabaseManager.shared.loadRates()
//            .tryMap({ response -> CurrencyData in
//                return response
//            })
//            .mapError({ error in
//                return PricesRepositoryError.failedToFetch
//            })
//            .eraseToAnyPublisher()
//    }
//    
//    
//    public func determineDataStaleCondition(with timestamp: TimeInterval) -> Bool {
//        let currentTime = Date().timeIntervalSince1970
//        let isDataStale = (currentTime - timestamp) >= 1800 // 1800 seconds = 30 minutes
//        
//        print("isDataStale:", isDataStale, "\nCurrentTime:", currentTime, "\nTimeStamp:", timestamp)
//        
//        return isDataStale
//    }
//    
    
    //MARK: Public Methods
//    public func getLatestRatesAndSetModel() {
//        // We create a new publisher with internal publishers for api and cache based fetch then we subscribe the output of publisher
//        withAnimation {
//            self.failure = nil
//        }
//        
//        cancellable = fetchRatesFromDB()
//            .flatMap { currencyData -> AnyPublisher<CurrencyData, PricesRepositoryError> in
//                if currencyData.rates.isEmpty || self.determineDataStaleCondition(with: TimeInterval(currencyData.timestamp)) {
//                    return self.fetchRatesFromAPI()
//                } else {
//                    print("==\nFetching cached exchange rates from db==")
//                    return Just(currencyData)
//                        .setFailureType(to: PricesRepositoryError.self)
//                        .eraseToAnyPublisher()
//                }
//            }
//            .catch { _ in
//                self.fetchRatesFromAPI()
//            }
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .failure(let error):
//                    print("Failed to get rates: \(error)")
//                    
//                    withAnimation {
//                        self.failure = error as? PricesRepositoryError // Added for readability
//                    }
//                    
//                case .finished:
//                    break
//                }
//            }, receiveValue: { [weak self] latestData in
//                self?.latestPrices = latestData.rates
//                
//                //TODO: Schedule a fetch after 30 mins if required
//            })
//            
//    }
    
//    public func refreshExchangeRates() {
//        withAnimation {
//            self.failure = nil
//        }
//        
//        self.fetchRatesFromAPI()
//            .handleEvents(receiveOutput: { response in
//                DatabaseManager.shared.saveRates(response.rates, timestamp: Int(Date().timeIntervalSince1970)) // Save data when api succeeds
//            })
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .failure(let error):
//                    print("Failed to get rates: \(error)")
//                    
//                    withAnimation {
//                        self.failure = error as? PricesRepositoryError // Added for readability
//                    }
//                    
//                case .finished:
//                    break
//                }
//            }, receiveValue: { [weak self] latestData in
//                self?.latestPrices = latestData.rates
//            })
//            .store(in: &cancellables)
//    }
    
    // MARK: - Currency Conversion Logic
//    func getConvertedCurrency(from src: String, to dest: String, amount: Double) -> Result<String, PricesRepositoryError> {
//        guard let srcRate = self.latestPrices[src], let destRate = self.latestPrices[dest] else {
//            return .failure(.missingExchangeRate)
//        }
//        
//        let convertedAmount = (amount / srcRate) * destRate
//        
//        // Handle potential overflow errors
//        guard convertedAmount.isFinite else {
//            return .failure(.overflowError)
//        }
//        
//        let formattedAmount = String(format: "%.2f", convertedAmount)
//        return .success(formattedAmount)
//        
//    }
}

//
//  CurrencyViewModel.swift
//  ConCurrency
//
//  Created by Siddharth S on 21/02/25.
//

import Foundation
import Combine

// MARK: - ViewModel
protocol ContentViewModelProtocol {
    var isCurrencySelectListPresented: Bool { get }
    var selectedCurrencyForConversionSRC: String? { get }
    var selectedCurrencyForConversionDEST: String? { get }
    
    func toggleCurrencySelectList() -> Void
}

class ContentViewModel: ObservableObject, ContentViewModelProtocol {
    @Published var isCurrencySelectListPresented: Bool = false
    @Published var selectedCurrencyForConversionSRC: String? = "INR"
    @Published var selectedCurrencyForConversionDEST: String? = nil
    
    
    @Published var pinnedConversions: Set<String> = [] // List of DEST which are pinned Set ensures unique pinned conversions and makes lookups faster (O(1) vs. O(n))
    
    var cancellables: Set<AnyCancellable> = []
    
    func toggleCurrencySelectList() {
        isCurrencySelectListPresented.toggle()
    }
}

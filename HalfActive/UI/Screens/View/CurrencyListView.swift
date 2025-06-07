////
////  CurrencyListView.swift
////  ConCurrency
////
////  Created by Siddharth S on 22/02/25.
////
//
//import SwiftUI
//
//struct CurrencyListView: View {
//    @EnvironmentObject private var viewModel: ContentViewModel
//    @EnvironmentObject private var pricesRepo: ExcercisesRepo
//    @State private var searchText: String = ""
//    
//    var filteredCurrencies: [String] {
//        if searchText.isEmpty {
//            return Array(pricesRepo.latestPrices.keys)
//        } else {
//            return pricesRepo.latestPrices.keys.filter { $0.localizedCaseInsensitiveContains(searchText) }
//        }
//    }
//    
//    var body: some View {
//            VStack {
//                TextField("Search currency", text: $searchText)
//                    .padding()
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                
//                Text("Select currency")
//                    .font(.subheadline)
//                    .foregroundStyle(.white.opacity(0.9))
//                
//                List(filteredCurrencies, id: \.self) { currency in
//                    Button {
//                        withAnimation(.easeInOut) {
//                            viewModel.selectedCurrencyForConversionSRC = currency
//                            viewModel.isCurrencySelectListPresented.toggle()
//                        }
//                    } label: {
//                        HStack {
//                            Text(currency)
//                                .font(.headline)
//                            Spacer()
//                            if let rate = pricesRepo.latestPrices[currency] {
//                                Text("Rate: \(rate, specifier: "%.2f")")
//                                    .foregroundColor(.gray)
//                            }
//                        }
//                    }
//                    .foregroundStyle(.white)
//                }
//                //.listRowBackground(Color.init(hex: "2f2f2f"))
//                .listRowSeparator(.hidden)
//                //.scrollContentBackground(.hidden)
//                .animation(.easeInOut, value: filteredCurrencies)
//                
//            }
//            .navigationTitle("Select Currency")
//    }
//}

////
////  CurrencyView.swift
////  ConCurrency
////
////  Created by Siddharth S on 25/02/25.
////
//
//import Foundation
//import SwiftUI
//
//// Currency View
//struct CurrencyView: View {
//    
//    @State var convertedAmt: String = ""
//    @State private var textSRC: String = ""
//    @State private var isObservedSRC: Bool = false
//    private let placeholderTextSRC = "Enter amount"
//
//    
//    @EnvironmentObject var coordinator: AppCoordinator
//    @EnvironmentObject private var viewModel: ContentViewModel
//    @EnvironmentObject private var pricesRepo: ExcercisesRepo
//    
//
//    @State var searchText: String = ""
//    
//    var body: some View {
//        
//        Text("ConCurrenc$")
//            .foregroundStyle(.white)
//            .font(.largeTitle)
//            .fontWeight(.semibold)
//        
//        
//        CurrentSelectionView(text: $textSRC, isObserved: $isObservedSRC)
//        
//        Image("separator")
//            .padding(.vertical, 2)
//        
//        if let selectedSrc = viewModel.selectedCurrencyForConversionSRC, !self.textSRC.isEmpty, pricesRepo.failure == nil {
//            ScrollView {
//                // Top empty space on scrollView to avoid the top gradient
//                Group {
//                    Color.white.opacity(0)
//                        .frame(height: 2)
//                }
//                
//                if viewModel.pinnedConversions.filter({$0 != selectedSrc}).count > 0 {
//                    Color.white.opacity(0.2)
//                        .frame(width: UIScreen.main.bounds.width - 64, height: 1)
//                    
//                    //TODO: We could pin frequent conversions here
////                    ScrollView(.horizontal) {
////                        HStack(spacing: 12) {
////                            ForEach(viewModel.pinnedConversions.filter({$0 != selectedSrc}), id: \.self) { currency in
////                                let convertedAmt = (try? pricesRepo.getConvertedCurrency(from: selectedSrc, to: currency, amount: Double(textSRC) ?? 0.0).get()) ?? ""
////                                ConvertedCurrencyView(convertedCurrency: convertedAmt, currentCurrency: currency)
////                                    .onTapGesture {
////                                        coordinator.navigate(to: .detail(currency + " " + convertedAmt))
////                                    }
////                                    .frame(width: 120)
////                            }
////                        }
////                        .padding(.vertical, 4)
////                    }
//                    
//                    
//                    Color.white.opacity(0.2)
//                        .frame(width: UIScreen.main.bounds.width - 64, height: 1)
//                        .padding(.bottom, 24)
//                }
//                   
//                VStack(spacing: 8) {
//                    
//                    TextField("Search currency", text: $searchText)
//                        .padding()
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                    LazyVGrid(
//                        columns: Array(repeating: GridItem(.fixed(120), spacing: 12), count: 3), // Fixed width for cells
//                        spacing: 16
//                    ) {
//                        if searchText.isEmpty {
//                            ForEach(
//                                pricesRepo.latestPrices.keys.sorted(by: { $0 > $1 }).filter { $0 != selectedSrc },
//                                id: \.self
//                            ) { symbol in
//                                let convertedAmt = (try? pricesRepo.getConvertedCurrency(from: selectedSrc, to: symbol, amount: Double(textSRC) ?? 0.0).get()) ?? ""
//                                
//                                ConvertedCurrencyView(convertedCurrency: convertedAmt, currentCurrency: symbol)
//                                    .frame(maxHeight: .infinity) // Allow dynamic height
//                                    .onTapGesture {
//                                        coordinator.navigate(to: .detail(symbol + " " + convertedAmt))
//                                    }
//                            }
//                        } else {
//                            ForEach(
//                                pricesRepo.latestPrices.keys.sorted(by: { $0 > $1 }).filter { $0.contains(searchText.uppercased()) },
//                                id: \.self
//                            ) { symbol in
//                                let convertedAmt = (try? pricesRepo.getConvertedCurrency(from: selectedSrc, to: symbol, amount: Double(textSRC) ?? 0.0).get()) ?? ""
//                                
//                                ConvertedCurrencyView(convertedCurrency: convertedAmt, currentCurrency: symbol)
//                                    .frame(maxHeight: .infinity) // Allow dynamic height
//                                    .onTapGesture {
//                                        coordinator.navigate(to: .detail(symbol + " " + convertedAmt))
//                                    }
//                            }
//                            
//                        }
//                        
//                    }
//                    .animation(.easeInOut, value: !self.textSRC.isEmpty)
//                }
// 
//            }
//            .overlay(
//                // Gradients
//                VStack {
//                    LinearGradient(colors: [Color.init(hex: "#121212").opacity(0.9), .clear], startPoint: .top, endPoint: .bottom)
//                        .frame(height: 8)
//                    Spacer()
//                    LinearGradient(colors: [Color.init(hex: "#121212").opacity(0.9), .clear], startPoint: .bottom, endPoint: .top)
//                        .frame(height: 8)
//                }
//            )
//        } else if pricesRepo.failure != nil  {
//            VStack(spacing: 16) {
//                
//                Text("Please check network conditions and try again")
//                    .foregroundStyle(.white)
//                    .font(.subheadline)
//                    .fontWeight(.semibold)
//                
//                Button {
//                    pricesRepo.getLatestRatesAndSetModel()
//                } label: {
//                    Text("Try Again!")
//                        .conCurrencyButtonDarkContentStyle(bgColor: Color.darkGray2, fgColor: .white, height: 52)
//                }
//                .foregroundStyle(.white)
//                .padding(.horizontal, 20)
//            }
//        }
//    }
//}
//
//
//struct CurrentSelectionView: View {
//    
//    @Binding var text: String
//    @Binding var isObserved: Bool
//    
//    @State var placeholderText = ""
//    
//    @EnvironmentObject var viewModel: ContentViewModel
//    @EnvironmentObject var pricesRepo: ExcercisesRepo
//    
//    var body: some View {
//        HStack(spacing: 16) {
//            ConTextField(
//                fieldText: $text,
//                fieldObserver: $isObserved,
//                currencySymbol: viewModel.selectedCurrencyForConversionSRC,
//                placeHolderText: placeholderText,
//                fieldTextCheck: nil
//            )
//            
//            if let selectedCurrencyForConversionSRC = viewModel.selectedCurrencyForConversionSRC {
//                HStack(spacing: 2) {
//                    Text(selectedCurrencyForConversionSRC)
//                    Image(systemName: "chevron.down")
//                }
//                .padding(12)
//                .font(.title3)
//                .foregroundStyle(.white)
//                .background(.white.opacity(0.22))
//                .cornerRadius(16)
//                .onTapGesture {
//                    viewModel.toggleCurrencySelectList()
//                }
//            }
//        }
//        .padding(.horizontal, 20)
//        .if(pricesRepo.isLoading, transform: {
//            $0.shimmer(when: .constant(true))
//        })
//    }
//}
//
//
//#Preview {
//    MainView()
//        .environmentObject(AppCoordinator())
//        .environmentObject(ExcercisesRepo())
//}

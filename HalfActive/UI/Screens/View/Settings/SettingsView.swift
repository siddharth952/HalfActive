////
////  SettingsView.swift
////  ConCurrency
////
////  Created by Siddharth S on 25/02/25.
////
//
//import SwiftUI
//
//struct SettingsView: View {
//    @EnvironmentObject var coordinator: AppCoordinator
//    @EnvironmentObject private var pricesRepo: ExcercisesRepo
//    
//    var body: some View {
//        ZStack(alignment: .top) {
//            
//            VStack {
//                Spacer()
//                
//                VStack(spacing: 16) {
//                    
//                    HStack {
//                        Text("Exchange rate settings")
//                            .foregroundStyle(.white)
//                            .font(.subheadline)
//                            .fontWeight(.semibold)
//                        
//                        Spacer()
//                    }
//                    
//                    Button {
//                        pricesRepo.refreshExchangeRates()
//                    } label: {
//                        Text("Refresh Database")
//                            .conCurrencyButtonDarkContentStyle(bgColor: Color.darkGray2, fgColor: .white, height: 44, font: .body)
//                    }
//                    .foregroundStyle(.white)
//                    .padding(.horizontal, 20)
//                }
//                .padding(.horizontal, 20)
//                Spacer()
//            }
//            
//            HStack {
//                Image(systemName: "chevron.left")
//                    .foregroundStyle(.white)
//                    .font(.title2)
//                    .onTapGesture {
//                        coordinator.pop()
//                    }
//                Spacer()
//            }
//            .padding(.horizontal, 20)
//            
//            HStack {
//                Text("Settings")
//                    .foregroundStyle(.white.opacity(0.9))
//                    .font(.headline)
//            }
//            .padding(.horizontal, 20)
//        }
//        
//        .background(AnimatedGradient())
//        .navigationBarBackButtonHidden()
//        .navigationTitle("")
//    }
//}
//
//#Preview {
//    SettingsView()
//        .environmentObject(AppCoordinator())
//        .environmentObject(ExcercisesRepo())
//}

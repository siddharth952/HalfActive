//
//  ContentView.swift
//  ConCurrency
//
//  Created by Siddharth S on 20/02/25.
//

import SwiftUI
import Combine

// MARK: - Main View
struct MainView: View {
    @State var isLoaded: Bool = false
    
    @StateObject private var viewModel = ContentViewModel()
    
    @EnvironmentObject var pricesRepository: ExcercisesRepo
    @EnvironmentObject var coordinator: AppCoordinator
    
    var body: some View {
        ZStack {
            Color.activeBg
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
//                CurrencyView()
//                    .padding([.top, .horizontal], 20)
//                    .environmentObject(viewModel)
//                    .environmentObject(pricesRepository)
//                    .environmentObject(coordinator)
                
                Spacer()
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Image(systemName: "gear")
                        .foregroundStyle(.white)
                        .font(.title2)
                        .onTapGesture {
                            coordinator.navigate(to: .settings)
                        }
                    
                }
                .padding(.horizontal, 20)
                Spacer()
            }
            
            
        }
//        .sheet(isPresented: $viewModel.isCurrencySelectListPresented) {
//            CurrencyListView()
//                .presentationDetents([.fraction(0.25), .fraction(0.8)])
//                .presentationDragIndicator(.hidden)
//                .presentationCornerRadius(16)
//                .environmentObject(pricesRepository)
//                .environmentObject(viewModel)
//            
//        }
        .background(isLoaded ? AnyView(AnimatedGradient()) : AnyView(Color.darkGray2))
        .onAppear {
            // To avoid issue with animation background
            if !self.isLoaded {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    withAnimation {
                        self.isLoaded = true
                    }
                    
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("")
        .toolbarVisibility(.hidden, for: .automatic)
    }
}

#Preview {
    MainView()
        .environmentObject(AppCoordinator())
        .environmentObject(ExcercisesRepo())
}

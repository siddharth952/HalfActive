//
//  ConvertedCurrencyView.swift
//  ConCurrency
//
//  Created by Siddharth S on 25/02/25.
//

import Foundation
import SwiftUI

// Favorite Currency View
struct ConvertedCurrencyView: View {
    let convertedCurrency: String
    let currentCurrency: String
    
    let isPinActive: Bool = true
    
    @EnvironmentObject private var viewModel: ContentViewModel
    
    var body: some View {
        VStack(spacing: 6) {
            
                HStack {
                    Spacer()
                    Button {
                        withAnimation {
                            if viewModel.pinnedConversions.contains(currentCurrency) {
                                viewModel.pinnedConversions.remove(currentCurrency)
                            } else {
                                viewModel.pinnedConversions.insert(currentCurrency)
                            }
                        }
                    } label: {
                        Image(systemName: viewModel.pinnedConversions.contains(currentCurrency) ? "pin.fill" : "pin")
                            .resizable()
                            .frame(width: 16, height: 21)
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.white)
                    }

                }
            
            Text(currentCurrency)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Text(currentCurrency.currencySymbol)
                .font(.footnote)
                .foregroundColor(.yellow)
            
            Text(convertedCurrency)
                .font(.callout)
                .foregroundColor(.white)
                .padding(8)
            
        }
        .padding()
        .background(Color.gray.opacity(0.15))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.2), radius: 3, x: 1, y: 2)
    }
}

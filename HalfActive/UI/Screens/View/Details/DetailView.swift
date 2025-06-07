//
//  DetailView.swift
//  ConCurrency
//
//  Created by Siddharth S on 24/02/25.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    let details: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.white)
                    .font(.title2)
                    .onTapGesture {
                        coordinator.pop()
                    }
                Spacer()
            }
            .padding(.horizontal, 20)
            Spacer()
            Text(details)
                .font(.title)
                .foregroundStyle(.white)
            Spacer()
        }
        .background(AnimatedGradient())
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    DetailView(details: "USD 10.0")
        .environmentObject(AppCoordinator())
}

//
//  CategoryCell.swift
//  HalfActive
//
//  Created by Siddharth S on 18/05/25.
//

import SwiftUI

struct CategoryCell: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Text(title)
                .font(.callout)
                .padding(.vertical, 8)
                .padding(.horizontal, 10)
                .background(isSelected ? .activePurple : .gray)
                .foregroundStyle(isSelected ? .black : .white)
                .cornerRadius(16)
        }
    }
}

#Preview {
    ZStack {
        Color.black
            .ignoresSafeArea(edges: .all)
        VStack(spacing: 38) {
            CategoryCell(title: "New Test", isSelected: false)
            CategoryCell(title: "New Test", isSelected: true)
            CategoryCell(title: "Title Here.....", isSelected: false)
        }
        
    }
    
    
}

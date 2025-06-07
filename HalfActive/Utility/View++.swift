//
//  View++.swift
//  ConCurrency
//
//  Ref: StackOverFlow
//

import Foundation
import SwiftUI

extension View {
    // For adding conditional checks on a view via a modifier
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

extension View {
    public func conCurrencyButtonDarkContentStyle(bgColor: Color = .black, fgColor: Color = .white, height: CGFloat = 52, border: Color = .clear, font: Font = .footnote) -> some View {
        HStack(alignment: .center) {
            Spacer()
            self.font(font)
            Spacer()
        }
        .frame(height: height)
        .background(bgColor)
        .foregroundColor(fgColor)
        .clipShape(Capsule())
        .contentShape(Capsule())
    }
}

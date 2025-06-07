//
//  ConTextField.swift
//  ConCurrency
//
//  Created by Siddharth S on 21/02/25.
//

import SwiftUI
import UIKit
import SwiftUI
import UIKit

struct ConTextField: View {
    @Binding var fieldText: String
    @Binding var fieldObserver: Bool
    @State private var textFieldState: Status = .initial

    var showSearchIcon: Bool = false
    var showCross: Bool = false
    var currencySymbol: String? = nil
    var suffix: String? = nil
    var keyboardType: UIKeyboardType = .decimalPad
    var suffixTextColor: Color = .white.opacity(0.35)
    var autocapitalization: UITextAutocapitalizationType = .sentences
    
    
    var backgroundColor: Color = .white

    let placeHolderText: String?
    let fieldTextCheck: (() -> Status?)?

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            if showSearchIcon {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                    .frame(width: 24, height: 24)
                    .padding(.leading, 16)
            } else if let symbol = currencySymbol?.currencySymbol, !symbol.isEmpty {
                Text(symbol)
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .fontWeight(.heavy)
                    .padding(.leading, 12)
                    .animation(.easeInOut, value: !fieldText.isEmpty)
            }

            CocoaTextField(
                text: Binding(
                    get: { fieldText },
                    set: { newValue in
                        
                        withAnimation(.easeInOut(duration: 0.45)) {
                            fieldText = newValue
                            textFieldState = fieldTextCheck?() ?? textFieldState
                        }
                    }
                ),
                onEditingChanged: { editing in
                    fieldObserver = editing
                    withAnimation(.easeInOut(duration: 0.45)) {
                        textFieldState = .highlighted
                    }
                },
                onCommit: {
                    fieldObserver = false
                    withAnimation(.easeInOut(duration: 0.45)) {
                        textFieldState = .initial
                    }
                }
            ) {
                Text(placeHolderText ?? "")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.35))
            }
            .autocapitalization(autocapitalization)
            .keyboardType(keyboardType)
            .foregroundColor(.white)
            .font(.footnote)
            .disableAutocorrection(true)
            .padding(.leading, 16)
            .padding(.vertical, 16)
            .onChange(of: fieldObserver) { isActive in
                if !isActive {
                    withAnimation {
                        textFieldState = .initial
                    }
                }
            }

            Spacer()

            if showCross, !fieldText.isEmpty {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .foregroundColor(.white.opacity(0.7))
                    .frame(width: 16, height: 16)
                    .onTapGesture { fieldText = "" }
                    .padding(.trailing, 16)
            } else if let suffixText = suffix {
                Text(suffixText)
                    .foregroundColor(suffixTextColor)
                    .font(.footnote)
                    .padding(.trailing, 16)
            }
        }
        .cornerRadius(12)
        .tint(.white)
        .background(backgroundColor.opacity(0.22))
        .cornerRadius(16)
    }

    enum Status {
        case initial
        case highlighted
        case invalid
        case available

        var color: Color {
            switch self {
            case .highlighted:
                return .white
            case .invalid:
                return .red
            case .available:
                return .green
            default:
                return .white
            }
        }
    }
}

extension String {
    var currencySymbol: String {
        let symbols: [String: String] = [
            "USD": "$", "EUR": "€", "GBP": "£", "INR": "₹", "JPY": "¥",
            "CNY": "¥", "AUD": "A$", "CAD": "C$", "CHF": "CHF", "SEK": "kr",
            "NZD": "NZ$", "SGD": "S$", "HKD": "HK$", "NOK": "kr", "KRW": "₩",
            "TRY": "₺", "RUB": "₽", "MXN": "Mex$", "BRL": "R$", "ZAR": "R"
        ]
        return symbols[self] ?? self
    }
}

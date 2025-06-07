//
//  OnboardingView.swift
//  HalfActive
//
//  Created by Siddharth S on 08/05/25.
//

import SwiftUI

struct OnboardingView: View {
    @State var emailAddress: String = ""
    @State var isEmailEditing: Bool = false
    @EnvironmentObject var coordinator: AppCoordinator
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.activeDark
                .ignoresSafeArea(.all)
            HumanSkeletonView()
            
//            LazyVStack(spacing: 24) {
//                
//                buildHeader()
//                    .frame(maxWidth: .infinity, alignment: .topLeading)
//                
//                Spacer()
//                
//                
//                LabeledTextFieldView(text: self.$emailAddress, isTextEditing: self.$isEmailEditing, fieldText: "Email Address", placeHolderText: "Enter email address")
//                
//                
//                
//                // Continue Button
//                Button(action: {}) {
//                    Text("Continue")
//                        .fontWeight(.semibold)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.purple)
//                        .foregroundColor(.white)
//                        .cornerRadius(16)
//                }
//
//                // Create Account Link
//                HStack(spacing: 4) {
//                    Text("Don't have an account?")
//                        .foregroundColor(.gray)
//                    Button("Create Account") {
//                        // Handle create account
//                    }
//                    .foregroundColor(.white)
//                    .bold()
//                }
//
//                // Or Divider
//                HStack {
//                    Rectangle()
//                        .frame(height: 1)
//                        .foregroundColor(.gray.opacity(0.5))
//                    Text("Or")
//                        .foregroundColor(.gray)
//                    Rectangle()
//                        .frame(height: 1)
//                        .foregroundColor(.gray.opacity(0.5))
//                }
//                .padding(.horizontal, 20)
//
//                // Social Buttons
//                HStack(spacing: 30) {
//                    ForEach(["google", "apple", "facebook"], id: \.self) { icon in
//                        Circle()
//                            .fill(Color(white: 0.15))
//                            .frame(width: 56, height: 56)
//                            .overlay(
//                                Image(icon)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 24, height: 24)
//                            )
//                    }
//                }
//                
//                
//                Button {
//                    
//                } label: {
//                    Text("Test   TestTestTest  t")
//                        .foregroundStyle(.white.opacity(0.9))
//                        .frame(maxWidth: .infinity)
//                }
//                    .foregroundStyle(.white)
//                    .padding(.horizontal, 16)
//                    .buttonStyle(ActiveButton())
//                
//                
//            }
            
            
//            .onAppear {
//                if let rootViewController = UIApplication.shared.keyWindow?.rootViewController  {
//                    rootViewController.present(TestViewController(), animated: true)
//                    
//                        }
//            }
            
        }
    }
    
    
    //MARK: Child Views
    
    // Header
    @ViewBuilder
    func buildHeader() -> some View {
        HStack {
            Button {
                self.coordinator.pop()
            } label: {
                Image(systemName: "arrow.backward")
                    .resizable()
                    .foregroundStyle(Color.white)
            }
            .frame(width: 24, height: 24, alignment: .leading)
            
//            Button {
//                
//            } label: {
//                Image(systemName: "arrow.backward")
//                    .resizable()
//                    .foregroundStyle(Color.white)
//            }
//            .frame(width: 28, height: 28, alignment: .leading)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AppCoordinator())
}

struct ActiveButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.activeBg)
            .foregroundStyle(.white)
            .clipShape(Capsule())
    }
    
}


class TestViewController: UIViewController {
    
    let popupView = PopupView()
    
    let stkView = UIStackView()
    
    // Dont use this
//    var textView: UILabel {
//        let lbl = UILabel()
//        lbl.text = "Test!"
//        return lbl
//    }
    
    //This ensures you're reusing the same UILabel instance when adding it to the stack view.
    var textView: UILabel = {
        let lbl = UILabel()
        //lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Test!"
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.backgroundColor = .red.withAlphaComponent(0.6)
        view.backgroundColor = .brown
        
        
        stkView.addArrangedSubview(textView)
        
        
        view.addSubview(stkView)
        
        view.addSubview(popupView)
        
        popupView.translatesAutoresizingMaskIntoConstraints = false
        stkView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stkView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stkView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popupView.topAnchor.constraint(equalTo: view.topAnchor),
            popupView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


struct LabeledTextFieldView: View {
    @Binding var text: String
    @Binding var isTextEditing: Bool
    let fieldText: String
    let placeHolderText: String
    
    var body: some View {
        Group {
            Text(fieldText)
                .foregroundStyle(.white)
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 12)
            
            ConTextField(fieldText: $text, fieldObserver: $isTextEditing, showSearchIcon: true, backgroundColor: .activeBg, placeHolderText: placeHolderText, fieldTextCheck: nil)
                
            
        }
        .padding(.horizontal)
    }
}

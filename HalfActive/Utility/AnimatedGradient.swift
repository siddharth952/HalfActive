//
//  AnimatedGradient.swift
//
//  Ref from StackOverFlow and modified
//

import SwiftUI

// For animated gradient effect
struct AnimatedGradient: View {
    @State private var start = UnitPoint(x: 0, y: -2)
    @State private var end = UnitPoint(x: 1, y: 1) // Initial end point

    let colors = [
        Color(#colorLiteral(red: 0.02, green: 0.02, blue: 0.05, alpha: 1)),
        Color(#colorLiteral(red: 0.05, green: 0.05, blue: 0.1, alpha: 1)),
        Color(#colorLiteral(red: 0.08629932255, green: 0.04182548076, blue: 0.1719261408, alpha: 1)),
    ]

    let timer = Timer.publish(every: 10, on: .main, in: .default).autoconnect()

    var body: some View {
        background
    }

    var background: some View {
        LinearGradient(gradient: Gradient(colors: colors), startPoint: start, endPoint: end)
            .edgesIgnoringSafeArea(.all)
            .animation(Animation.easeInOut(duration: 10).repeatForever(autoreverses: true))
            .onReceive(timer) { _ in
                // Smoothly animate the start and end points
                withAnimation(.easeInOut(duration: 5)) {
                    self.start = UnitPoint(x: Double.random(in: 0...1), y: Double.random(in: 0...1))
                    self.end = UnitPoint(x: Double.random(in: 0...1), y: Double.random(in: 0...1))
                }
            }
    }
}

#Preview {
    AnimatedGradient()
}

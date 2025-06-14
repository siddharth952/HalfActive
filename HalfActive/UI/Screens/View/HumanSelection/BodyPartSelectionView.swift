//
//  BodyPartSelectionView.swift
//  HalfActive
//
//  Created by Siddharth S on 18/05/25.
//

import SwiftUI

struct BodyPart: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
    let position: CGPoint
}

struct HumanSkeletonView: View {
    @Namespace private var animation
    @State private var selectedPart: BodyPart?
    @State private var zoomed = false
    
    let bodyParts: [BodyPart] = [
        .init(name: "Chest", color: .red, position: CGPoint(x: 0.5, y: 0.3)),
        .init(name: "Biceps", color: .blue, position: CGPoint(x: 0.3, y: 0.35)),
        .init(name: "Triceps", color: .purple, position: CGPoint(x: 0.7, y: 0.35)),
        .init(name: "Legs", color: .green, position: CGPoint(x: 0.5, y: 0.7)),
    ]
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("Human Skeleton")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                    .padding(.top)
                
                SceneViewRepresentable(selectedPart: .constant(nil), zoomedPartName: .constant(nil))
                
                
//                GeometryReader { geo in
//                    ZStack {
//                        // Simplified body shape
//                        RoundedRectangle(cornerRadius: 30)
//                            .fill(Color.gray.opacity(0.2))
//                            .frame(width: geo.size.width * 0.4, height: geo.size.height * 0.6)
//                            .position(x: geo.size.width * 0.5, y: geo.size.height * 0.5)
//                        
//                        RoundedRectangle(cornerRadius: 30)
//                            .fill(Color.gray.opacity(0.25))
//                            .frame(width: geo.size.width * 0.1, height: geo.size.height * 0.33)
//                            .position(x: geo.size.width * 0.5, y: geo.size.height * 0.5)
//                        
//                        ForEach(bodyParts) { part in
//                            Circle()
//                                .fill(part.color)
//                                .frame(width: zoomed && selectedPart?.id == part.id ? 80 : 40,
//                                       height: zoomed && selectedPart?.id == part.id ? 80 : 40)
//                                .position(x: geo.size.width * part.position.x,
//                                          y: geo.size.height * part.position.y)
//                                .overlay(
//                                    Text(part.name)
//                                        .font(.caption)
//                                        .foregroundColor(.white)
//                                        .position(x: geo.size.width * part.position.x,
//                                                  y: geo.size.height * part.position.y)
//                                )
//                                .onTapGesture {
//                                    withAnimation(.spring()) {
//                                        selectedPart = part
//                                        zoomed = true
//                                    }
//                                }
//                        }
//                    }
//                }
//                .frame(height: 700)
//                Spacer()
            }
        }
        .sheet(item: $selectedPart) { part in
            BodyPartDetailView(part: part, zoomed: $zoomed)
        }
    }
}

struct BodyPartDetailView: View {
    let part: BodyPart
    @Binding var zoomed: Bool
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<5) { i in
                    Text("\(part.name) info item \(i+1)")
                }
            }
            .navigationTitle(part.name)
            .navigationBarItems(trailing: Button("Done") {
                zoomed = false
            })
        }
    }
}

#Preview {
    HumanSkeletonView()
}

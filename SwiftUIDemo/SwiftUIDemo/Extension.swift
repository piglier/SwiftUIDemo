//
//  Extension.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/2/28.
//

// roundRectBackground

import SwiftUI


extension AnyTransition {
    static let asymmetricInserion = Self.asymmetric(
        insertion: .opacity.animation(.easeInOut(duration: 0.5).delay(0.2)),
        removal: .opacity.animation(.easeInOut(duration: 0.4)))
    
    static let foodTopOpacity = Self.move(edge: .top).combined(with: .opacity)
    
}


extension Animation {
    static let foodEaseInOut = easeIn(duration: 0.5)
    static let foodSpring = spring(dampingFraction: 0.5)
}

extension View {
    func capluseButton() -> some View {
        buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
    }
    
    func foodMainButton(radius: CGFloat = 8, style: some ShapeStyle = Color(.systemBackground)) -> some View {
        RoundedRectangle(cornerRadius: radius).foregroundStyle(style)
    }
}


extension Color {
    static let bg = Color(.systemBackground)
    static let bg2 = Color(.secondarySystemBackground)
}

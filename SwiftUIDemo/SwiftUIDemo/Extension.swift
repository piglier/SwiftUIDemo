//
//  Extension.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/2/28.
//

// roundRectBackground

import SwiftUI


extension AnyTransition {
    static let delayInserion = Self.asymmetric(
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
    
    func foodMainButton(radius: CGFloat = 8, style: some ShapeStyle = .bg) -> some View {
        RoundedRectangle(cornerRadius: radius).fill(.bg)
    }
}


extension ShapeStyle where Self == Color {
    static var bg: Color { Color(.systemBackground) }
    static var bg2: Color { Color(.secondarySystemBackground) }
    
}

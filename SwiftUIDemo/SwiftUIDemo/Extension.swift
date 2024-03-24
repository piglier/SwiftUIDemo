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
    func capluseButton(_ borderShape: ButtonBorderShape = .capsule) -> some View {
        buttonStyle(.borderedProminent)
            .buttonBorderShape(borderShape)
            .controlSize(.large)
    }
    
    func foodMainButton(radius: CGFloat = 8, style: some ShapeStyle = .bg) -> some View {
        RoundedRectangle(cornerRadius: radius).fill(.bg)
//        background(RoundedRectangle(cornerRadius: radius).fill(.bg))
    }
    
    func mainButtonStyle(shape: ButtonBorderShape = .capsule) -> some View {
        buttonStyle(.borderedProminent)
        .buttonBorderShape(shape)
        .controlSize(.large)
    }
}


extension ShapeStyle where Self == Color {
    static var bg: Color { Color(.systemBackground) }
    static var bg2: Color { Color(.secondarySystemBackground) }
    static var groupBg: Color { Color(.systemGroupedBackground) }
    
}


extension AnyLayout {
    static func isUseVstack(if condition: Bool, @ViewBuilder content: @escaping () -> some View) -> some View {
        let layout = condition ? AnyLayout(VStackLayout(spacing: 30)) : AnyLayout(HStackLayout(spacing: 30))
        return layout(content)
    }
}

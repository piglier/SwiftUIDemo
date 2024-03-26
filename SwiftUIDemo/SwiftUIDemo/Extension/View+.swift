//
//  View+.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/3/26.
//

import SwiftUI

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
    
    func sheet(item: Binding<(some View & Identifiable)?>) -> some View {
        sheet(item: item) { $0 }
    }
    
    /// - Tag: push
    func push(to alignment: TextAlignment) -> some View {
        switch alignment {
        case .leading:
            return frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        case .center:
            return frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
        case .trailing:
            return frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
        }
    }
    
    /// Shortcut: [push(to: .center)](x-source-tag://push)
    func maxWidth() -> some View {
        push(to: .center)
    }
    
    
    ///  Geometry Reader
    func readGeometry<Key: PreferenceKey, Value>(_ key: Key.Type, keyPath: KeyPath<GeometryProxy, Value>) -> some View where Key.Value == Value {
        overlay {
            GeometryReader { proxy in
                Color.clear.preference(key: key, value: proxy[keyPath: keyPath])
            }
        }
    }
}

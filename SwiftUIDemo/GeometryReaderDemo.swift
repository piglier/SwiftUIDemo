//
//  GeometryReaderDemo.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/3/16.
//

import SwiftUI


extension CGRect {
    var endPosition: CGPoint { .init(x: maxX, y: maxY)}
    
    var coverage: String {
        origin.debugDescription + " ~ " + endPosition.debugDescription
    }
}


extension CGSize: CustomStringConvertible {
    public var description: String { "\(Int(width)) x \(Int(height))" }
}

extension CGPoint: CustomStringConvertible {
    public var description: String { "x: \(Int(x)) y: \(Int(y))" }
}

struct PreferedColorKey: PreferenceKey {
    
    static var defaultValue: Color = .accentColor
    
    static func reduce(value: inout Color, nextValue: () -> Color) {
        value = nextValue()
    }
}


fileprivate struct GeometryReaderIntroView: View {
    @State private var spacing: CGFloat = 0
    
    @State private var fishSize: CGSize =  .zero
    
    var body: some View {
//        Color.bg2.frame(height: spacing)
        GeometryReader { proxy in
            let size: CGSize = proxy.size
            let global: CGRect = proxy.frame(in: .global)
            let local: CGRect = proxy.frame(in: .local)
            
            VStack(alignment: .leading, spacing: 20) {
                Text("大小: " + size.debugDescription)
                Text("global location:\n" + global.debugDescription)
                Text("local location:\n " + local.debugDescription)
            }.background {
                GeometryReader { proxy in
//                    let _ = fishSize = proxy.size
                    Color.clear.preference(key: PreferedColorKey.self, value: .yellow)
                }
            }
        }.border(.green, width: 2)
    }
}


struct Preview_GeometryReaderIntroView: PreviewProvider {
    static var previews: some View {
        GeometryReaderIntroView()
    }
}

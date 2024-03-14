//
//  ShapeStyleView.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/2/28.
//

import SwiftUI


struct ShapeStyleView: View {
    var body: some View {
        VStack {
            Image("dinner")
            Circle().fill(.image(.init("dinner"), scale: 0.2))
            Text("Hellow")
                .font(.title).bold()
                .foregroundStyle(.linearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                .background(Color.bg2.scaleEffect(x: 1.5, y: 1.3).blur(radius: 10) )
                
        }
    }
}



struct ShapeStyleView_Preview: PreviewProvider {
    static var previews: some View {
        ShapeStyleView()
    }
}





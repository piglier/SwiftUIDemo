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
            Circle().fill(.teal)
            Circle().fill(.teal.gradient)
            Circle().fill(.linearGradient(colors: [.pink, .gray], startPoint: .topTrailing, endPoint: .bottomLeading))
            LinearGradient(gradient: /*@START_MENU_TOKEN@*/Gradient(colors: [Color.red, Color.blue])/*@END_MENU_TOKEN@*/, startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
            Text("Hello World").font(.system(size: 50).bold()).foregroundStyle(.linearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
            
            Circle().fill(.yellow).overlay {
                Text("Hellow")
                    .font(.title).bold()
                    .foregroundStyle(.linearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
            }
        }
//        ZStack {
//            Circle().fill(.yellow)
//            Image("dinner")
//            Circle().fill(.image(.init("dinner"), scale: 0.2))
//            Text("Hellow")
//                .font(.title).bold()
//                .foregroundStyle(.linearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
//                .background(Color.bg2.scaleEffect(x: 1.5, y: 1.3).blur(radius: 10) )
//                
//        }
    }
}



struct ShapeStyleView_Preview: PreviewProvider {
    static var previews: some View {
        ShapeStyleView()
    }
}





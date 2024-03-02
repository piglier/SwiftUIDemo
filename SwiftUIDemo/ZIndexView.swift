//
//  ZIndexView.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/3/2.
//

import SwiftUI


struct ZIndexView: View {
    @State var shouldShow = ["左上": true,"左下": true,"右上": true,"右下": true]
    var body: some View {
        ZStack {
            buildTextView(text: "左上", position: .topLeading)
            buildTextView(text: "右上", position: .topTrailing)
            buildTextView(text: "左下", position: .bottomLeading)
            buildTextView(text: "右上", position: .bottomTrailing)
        }.animation(.easeInOut, value: shouldShow)
        
    }
    
    @ViewBuilder func buildTextView(text: String, position: Alignment) -> some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(.teal.gradient)
            .frame(width: 180, height: 140)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: position)
            .onTapGesture {
                shouldShow[text]!.toggle()
            }
        if shouldShow[text]! {
            Text(text)
                .font(.largeTitle.bold()).foregroundStyle(.white)
                .padding(50)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: position).allowsTightening(false)
        }
    }
}



struct Preview_ZIndexView: PreviewProvider {
    static var previews: some View {
        ZIndexView()
    }
}

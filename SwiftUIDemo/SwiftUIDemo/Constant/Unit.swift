//
//  Unit.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/3/31.
//
import SwiftUI

enum Units: String, CaseIterable, Identifiable, View {
    case g = "g", lb = "lb"
    
    var id: Self { self }
    
    var body: some View {
        Text(self.rawValue)
    }
}

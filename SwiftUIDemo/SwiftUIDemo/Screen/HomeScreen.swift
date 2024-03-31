//
//  HomeScreen.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/3/27.
//

import SwiftUI

extension HomeScreen {
    enum Tab: View, CaseIterable {
        case picker, list, settings
        
        
        var body: some View {
            content.tabItem { tabLabel.labelStyle(.iconOnly) }
        }
        
        
        @ViewBuilder
        private var content: some View {
            switch self {
            case .picker: FoodPickerScreen()
            case .list:  FoodListScreen()
            case .settings: SettingsScreen()
            }
        }
        
        
        private var tabLabel: some View {
            switch self {
            case .picker: return Label("Home", systemImage: .house)
            case .list: return Label("List", systemImage: .list)
            case .settings: return Label("Setting", systemImage: .gear)
            }
        }
    }
}



struct HomeScreen: View {
    @State var currentTag: Tab = .settings
    var body: some View {
        TabView(selection: $currentTag) {
            ForEach(Tab.allCases, id: \.self) { $0 }
        }
    }
}


struct Preview_HomeScreen: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

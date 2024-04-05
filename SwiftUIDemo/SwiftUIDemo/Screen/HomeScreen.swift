//
//  HomeScreen.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/3/27.
//

import SwiftUI

extension HomeScreen {
    enum Tab: String, View, CaseIterable {
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
    @AppStorage(.isUseDarkMode) private var isUseDarkMode: Bool = false
    @State var tab: Tab = {
        let setting = UserDefaults.standard.value(forKey: UserDefaults.Key.startTab.rawValue) as? String ?? ""
        return Tab(rawValue: setting) ?? .list
    }()
    var body: some View {
        
        NavigationStack {
            TabView(selection: $tab) {
                ForEach(Tab.allCases, id: \.self) { $0 }
            }
            .preferredColorScheme(isUseDarkMode ? .dark : .light)
        }
    }
}


struct Preview_HomeScreen: PreviewProvider {
//    若是改用properywrapped來啟用, 可以用讓Preview去繼承View
//    @AppStorage(.startTab) private var tab: HomeScreen.Tab = .list
//
//    var body: some View {
//        HomeScreen(tab: tab)
//    }
    
    static var previews: some View {
        HomeScreen()
    }
}

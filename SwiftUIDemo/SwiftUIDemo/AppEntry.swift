//
//  SwiftUIDemoApp.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/2/18.
//

import SwiftUI

@main
struct AppEntry: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
    init() {
        applyTabBarBackground()
    }
    
    func applyTabBarBackground() {
        let tabbarAppearance = UITabBarAppearance()
        tabbarAppearance.configureWithTransparentBackground()
        tabbarAppearance.backgroundColor = .secondarySystemBackground.withAlphaComponent(0.3)
        tabbarAppearance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterial)
        UITabBar.appearance().scrollEdgeAppearance = tabbarAppearance
    }
}

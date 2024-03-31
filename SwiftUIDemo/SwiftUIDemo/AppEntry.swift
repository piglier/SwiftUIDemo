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
}

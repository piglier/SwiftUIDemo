//
//  SettingsScreen.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/3/30.
//

import SwiftUI

struct SettingsScreen: View {
    
    @AppStorage(.isUseDarkMode) private var isUseDarkMode: Bool = false
    @AppStorage(.preferredWeightUnit) private var unit: MyWeightUnit
    @AppStorage(.startTab) private var initPage: HomeScreen.Tab = .list
    @State private var confirmationDialog: Dialog = .inactive
    
    private var showDialog: Binding<Bool> {
        Binding(
            get: { confirmationDialog != .inactive},
            set: { _ in confirmationDialog = .inactive }
            )
    }
    var body: some View {
        Form {
            Section("基本設定") {
                Toggle(isOn: $isUseDarkMode) {
                    Label("深色模式", systemImage: .moon)
                }
                Picker(selection: $unit) {
                    ForEach(MyWeightUnit.allCases) { $0 }
                } label: {
                    Label("單位", systemImage: .unitSign)
                }
                Picker(selection: $initPage) {
                    Text("食物清單").tag(HomeScreen.Tab.list)
                    Text("隨機食物").tag(HomeScreen.Tab.picker)
                } label: {
                    Label("啟動畫面", systemImage: .house)
                }
            }
            
            Section("危險區域") {
                ForEach(Dialog.allCases) { d in
                    if (d != .inactive) { Button(d.rawValue) { confirmationDialog = d } }
                }
            }
            .confirmationDialog(confirmationDialog.rawValue, 
                                isPresented: showDialog,
                                titleVisibility: .visible) {
                    Button("確定") {
                        confirmationDialog.action()
                    }
                    Button("取消", role: .cancel) {}
                } message: {
                    Text(confirmationDialog.message)
                }

        }
    }
    
    
    
    private enum InitialPage: String, CaseIterable, Identifiable, View {
        case random = "隨機食物", list = "食物清單"
        
        var id: Self { self }
        
        var body: some View {
            Text(self.rawValue)
        }
    }
}


private enum Dialog: String, CaseIterable, Identifiable {
    case resetSettings = "重置設定"
    case resetFoodList = "重置食物紀錄"
    case inactive
    
    var id: Self { self }
    
    var message: String {
        switch self {
        case .resetSettings:
            return "將重置顏色、單位等設置，\n此操作無法復原，確定進行嗎？"
        case .resetFoodList:
            return "將重置食物清單，\n此操作無法復原，確定進行嗎？"
        case .inactive:
            return ""
        }
    }
    
    func action() {
        switch self {
        case .resetSettings:
            let keys: [UserDefaults.Key] = [.isUseDarkMode, .startTab, .preferredWeightUnit]
            for key in keys {
                UserDefaults.standard.removeObject(forKey: key.rawValue)
            }
        case .resetFoodList:
            UserDefaults.standard.removeObject(forKey: UserDefaults.Key.foodList.rawValue)
        case .inactive:
            return
        }
    }
}


struct Preview_SettingsScreen: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
    }
}

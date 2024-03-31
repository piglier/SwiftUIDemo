//
//  SettingsScreen.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/3/30.
//

import SwiftUI

struct SettingsScreen: View {
    @State private var isUseDarkMode: Bool = false
    @State private var unit: Units = .g
    @State private var initPage: InitialPage = .list
    @State private var confirmationDialog: Dialog = .inactive
    
    private var showDialog: Binding<Bool> {
        Binding(
            get: { confirmationDialog != .inactive},
            set: { _ in confirmationDialog = .inactive }
            )
    }
    var body: some View {
        Form {
            Section("基本設定") {}
            Toggle(isOn: $isUseDarkMode) {
                Label("深色模式", systemImage: .moon)
            }
            Picker(selection: $unit) {
                ForEach(Units.allCases) { $0 }
            } label: {
                Label("單位", systemImage: .unitSign)
            }
            
            // TODO: 確認可不可用enum
            Picker(selection: $initPage) {
//                ForEach(InitialPage.allCases) { $0 }
                Text("食物清單").tag(HomeScreen.Tab.list)
                Text("隨機食物").tag(HomeScreen.Tab.picker)
            } label: {
                Label("啟動畫面", systemImage: .house)
            }
            
            Section("危險區域") {}
            ForEach(Dialog.allCases) { d in
                if (d != .inactive) { Button(d.rawValue) { confirmationDialog = d } }
            }
            .confirmationDialog(confirmationDialog.rawValue, 
                                isPresented: showDialog,
                                titleVisibility: .visible) {
                    Button("確定"){}
                    Button("取消", role: .cancel) {}
                } message: {
                    Text(confirmationDialog.message)
                }

        }
    }
    
    private enum Units: String, CaseIterable, Identifiable, View {
        case g = "g", kg = "kg"
        
        var id: Self { self }
        
        var body: some View {
            Text(self.rawValue)
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
}


struct Preview_SettingsScreen: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
    }
}

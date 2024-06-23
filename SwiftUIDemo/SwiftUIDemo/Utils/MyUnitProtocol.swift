//
//  MyUnitProtocol.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/6/23.
//

import SwiftUI

protocol MyUnitProtocol: Identifiable, View, CaseIterable, Codable, RawRepresentable where RawValue == String, AllCases: RandomAccessCollection {
    static var userDefaultKey: UserDefaults.Key { get }
    static var defaultUnit: Self { get }
    
    associatedtype T: Dimension
    
    var dimension: T { get }
}

extension MyUnitProtocol {
    static func getPreferredUnit(form store: UserDefaults = .standard) -> Self {
        AppStorage(userDefaultKey, store: store).wrappedValue
    }
}

extension MyUnitProtocol {
    var id: Self { self }
}

extension MyUnitProtocol {
    var localizedSymbol: String {
        let formatter = MeasurementFormatter()
        formatter.locale = Locale(identifier: "zh")
        return formatter.string(from: dimension)
    }
    
    var body: some View {
        Text(localizedSymbol)
    }
}


extension ForEach where Data.Element: Identifiable & View, ID == Content.ID, Content == Data.Element {
    init(_ data: Data) {
        self.init(data) { $0 }
    }
}


//extension Unit {
//    var localizedSymbol: String {
//        let formatter = MeasurementFormatter()
//        // 目前無法切換語言的, locale都會得到en-zh而無法得到localiztion的結果, 目前先自己定義
////        formatter.locale = Locale(identifier: "zh")
//    return formatter.string(from: self)
//    }
//}

//
//  Array+.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/4/5.
//

import Foundation

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8), let array = try? JSONDecoder().decode(Self.self, from: data) else { return nil }
        self = array
    }
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self), let result = String(data: data, encoding: .utf8) else { return "" }
        return result
    }
}

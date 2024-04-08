//
//  SuffixWrapper.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/2/27.
//

import Foundation

@propertyWrapper struct Suffix: Equatable {
    var wrappedValue: Double
    let suffix: String
    
    var projectedValue: String {
        let suitableSuffix: String = suffix.isEmpty ? "" : " \(suffix)"
        return wrappedValue.formatted(.number.precision(.fractionLength(0...1))) + suitableSuffix
    }
    
    init(wrappedValue: Double, _ suffix: String) {
        self.wrappedValue = wrappedValue
        self.suffix = suffix
    }
}

extension Suffix: Codable {}

//
//  SuffixWrapper.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/2/27.
//

import Foundation

typealias energyUnit = Suffix<MyEnergyUnit>
typealias weightUnit = Suffix<MyWeightUnit>

@propertyWrapper struct Suffix<Unit: MyUnitProtocol & Equatable>: Equatable {
    var wrappedValue: Double
    var unit: Unit
    var store: UserDefaults = .standard
    
    var projectedValue: Self {
        get { self }
        set { self = newValue }
    }
    
    var description: String {
        let preferUnit = Unit.getPreferredUnit(form: store)
        let measurement = Measurement(value: wrappedValue, unit: unit.dimension)
        let converted = measurement.converted(to: preferUnit.dimension)
        
//        return converted.formatted(.measurement(width: .abbreviated, usage: .general, numberFormatStyle: .number.precision(.fractionLength(0...1))))
        return converted.value.formatted(.number.precision(.fractionLength(0...1))) + " " + preferUnit.localizedSymbol
//        let suitableSuffix: String = unit.isEmpty ? "" : " \(unit)"
//        return wrappedValue.formatted(.number.precision(.fractionLength(0...1))) + suitableSuffix
//        return wrappedValue.formatted(.number.precision(.fractionLength(0...1))) + " " + unit.rawValue
    }
    
    init(wrappedValue: Double, _ unit: Unit, store: UserDefaults = .standard) {
        self.wrappedValue = wrappedValue
        self.unit = unit
        self.store = store
    }
}

extension Suffix: Codable {
    enum CodingKeys: CodingKey {
        case wrappedValue
        case unit
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Suffix<Unit>.CodingKeys> = try decoder.container(keyedBy: Suffix<Unit>.CodingKeys.self)
        
        self.wrappedValue = try container.decode(Double.self, forKey: Suffix<Unit>.CodingKeys.wrappedValue)
        self.unit = try container.decode(Unit.self, forKey: Suffix<Unit>.CodingKeys.unit)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Suffix<Unit>.CodingKeys> = encoder.container(keyedBy: Suffix<Unit>.CodingKeys.self)
        
        try container.encode(self.wrappedValue, forKey: Suffix<Unit>.CodingKeys.wrappedValue)
        try container.encode(self.unit, forKey: Suffix<Unit>.CodingKeys.unit)
    }
}

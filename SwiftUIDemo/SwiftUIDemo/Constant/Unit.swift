//
//  Unit.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/3/31.
//
import Foundation


enum MyEnergyUnit: String, MyUnitProtocol {
    case cal = "calories", kil = "大卡"
    static var userDefaultKey = UserDefaults.Key.preferredEnergyUnit
    static var defaultUnit: MyEnergyUnit = .cal


    var dimension: UnitEnergy {
        switch self {
        case .cal: return .calories
        case .kil: return .kilocalories
        }
    }
}

enum MyWeightUnit: String, MyUnitProtocol {
    case g = "g", pounds = "lb", oz
    static var userDefaultKey = UserDefaults.Key.preferredWeightUnit
    static var defaultUnit: MyWeightUnit = .g
    
    
    var dimension: UnitMass {
        switch self {
        case .g: .grams
        case .pounds: .pounds
        case .oz: .ounces
        }
    }
}

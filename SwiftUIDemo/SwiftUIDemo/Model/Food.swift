//
//  Food.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/2/24.
//

import SwiftUI


struct Food: Equatable, Identifiable {
    var id = UUID()
    var name: String
    var image: String
    @energyUnit var calorie: Double
    @weightUnit var carb: Double
    @weightUnit var fat: Double
    @weightUnit var protein: Double
    
}


extension Food {
    private init(id: UUID = UUID(), name: String, image: String, calorie: Double, carb: Double, fat: Double, protein: Double) {
        self.id = id
        self.name = name
        self.image = image
        self._calorie = energyUnit(wrappedValue: calorie, .cal)
        self._carb = weightUnit(wrappedValue: carb, .g)
        self._fat = weightUnit(wrappedValue: fat, .g)
        self._protein = weightUnit(wrappedValue: protein, .g)
    }
    
    static let examples = [
        Food(name: "漢堡", image: "🍔", calorie: 294, carb: 14, fat: 24, protein: 17),
        Food(name: "沙拉", image: "🥗", calorie: 89, carb: 20, fat: 0, protein: 1.8),
        Food(name: "披薩", image: "🍕", calorie: 266, carb: 33, fat: 10, protein: 11),
        Food(name: "義大利麵", image: "🍝", calorie: 339, carb: 74, fat: 1.1, protein: 12),
        Food(name: "雞腿便當", image: "🍗🍱", calorie: 191, carb: 19, fat: 8.1, protein: 11.7),
        Food(name: "刀削麵", image: "🍜", calorie: 256, carb: 56, fat: 1, protein: 8),
        Food(name: "火鍋", image: "🍲", calorie: 233, carb: 26.5, fat: 17, protein: 22),
        Food(name: "牛肉麵", image: "🐄🍜", calorie: 219, carb: 33, fat: 5, protein: 9),
        Food(name: "關東煮", image: "🥘", calorie: 80, carb: 4, fat: 4, protein: 6),
    ]
    
    static var new: Food {
        @AppStorage(.preferredWeightUnit) var preferWeightUnit: MyWeightUnit
        @AppStorage(.preferredEnergyUnit) var preferEnergyUnit: MyEnergyUnit
        return Food(
            name: "",
            image: "",
            calorie: .init(wrappedValue: .zero, preferEnergyUnit),
            carb: .init(wrappedValue: .zero, preferWeightUnit),
            fat: .init(wrappedValue: .zero, preferWeightUnit),
            protein: .init(wrappedValue: .zero, preferWeightUnit)
        )
    }
}

extension Food: Codable {}

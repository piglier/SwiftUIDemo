//
//  Sheet.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/3/26.
//
import SwiftUI

enum FoodSheet: View, Identifiable {
    case newFood((Food) -> Void)
    case editFood(Binding<Food>)
    case detailFood(Food)
    
    var id: Food.ID {
        switch self {
        case .newFood(_):               return UUID()
        case .editFood(let binding):    return binding.wrappedValue.id
        case .detailFood(let food):     return food.id
        }
    }
    
    var body: some View {
        switch self {
        case .newFood(let onSubmit):
            FoodListScreen.FoodForm(food: .new, onSubmit: onSubmit)
        case .editFood(let binding):
            FoodListScreen.FoodForm(food: binding.wrappedValue) { food in
                binding.wrappedValue = food
            }
        case .detailFood(let food):
            FoodListScreen.DetailSheet(food: food)
        }
    }
}

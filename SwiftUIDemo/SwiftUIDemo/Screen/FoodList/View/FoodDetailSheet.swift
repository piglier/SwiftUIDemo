//
//  FoodDetailSheet.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/3/24.
//

import SwiftUI


extension FoodListScreen {
    struct DetailSheet: View {
        @Environment(\.dynamicTypeSize) var textSize
        @State private var detialSheetHeight: CGFloat = FoodSheetHeight.defaultValue
        @State var food: Food
        
        private struct FoodSheetHeight: PreferenceKey {
            static var defaultValue: CGFloat = 300
            static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
                value = nextValue()
            }
        }
        
        private func buildNutritionView(title: String, value: String) -> some View {
            GridRow {
                Text(title).gridCellAnchor(.leading)
                Text(value).gridCellAnchor(.trailing)
            }
        }
        
        var body: some View {
            let shouldShowVStack = textSize.isAccessibilitySize || food.image.count > 1
            
            AnyLayout.isUseVstack(if: shouldShowVStack) {
                Text(food.image).font(.system(size: 100)).lineLimit(1).minimumScaleFactor(0.5)
                Grid(horizontalSpacing: 30, verticalSpacing: 12) {
                    buildNutritionView(title: "熱量", value: food.$calorie)
                    buildNutritionView(title: "蛋白質", value: food.$protein)
                    buildNutritionView(title: "脂肪", value: food.$fat)
                    buildNutritionView(title: "碳水", value: food.$carb)
                }
            }
            .padding(.vertical)
            .readGeometry(FoodSheetHeight.self, keyPath: \.size.height)
            .onPreferenceChange(FoodSheetHeight.self, perform: { value in
                detialSheetHeight = value
            })
            .presentationDetents([.height(detialSheetHeight)])
        }
    }
}



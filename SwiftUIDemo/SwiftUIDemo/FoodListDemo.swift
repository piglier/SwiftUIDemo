//
//  FoodListDemo.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/3/3.
//

import SwiftUI

struct FoodListDemo: View {
    @Environment(\.editMode) var editMode
    @Environment(\.dynamicTypeSize) var textSize
    @State private var foods: [Food] = Food.examples
    @State private var selectedFood = Set<Food.ID>()
    
    private var isEditing: Bool { editMode?.wrappedValue == .active }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            titleBar
            List($foods, editActions: .all, selection: $selectedFood) { $food in
                Text(food.name).padding(.vertical, 10)
            }
            .listStyle(.plain)
            .padding(.horizontal)
        }.background(.groupBg)
            .safeAreaInset(edge: .bottom, content: buildFloatButton)
            .sheet(isPresented: .constant(true), content: {
                let food = foods.first!
                let shouldShowVStack = textSize.isAccessibilitySize || food.image.count > 1
                
                AnyLayout.isUseVstack(if: shouldShowVStack) {
                    Text(food.image).font(.system(size: 100)).lineLimit(1).minimumScaleFactor(0.5)
                    Grid(horizontalSpacing: 30, verticalSpacing: 12) {
                        buildNutritionView(title: "熱量", value: food.$calorie)
                        buildNutritionView(title: "蛋白質", value: food.$protein)
                        buildNutritionView(title: "脂肪", value: food.$fat)
                        buildNutritionView(title: "碳水", value: food.$carb)
                    }
                }.presentationDetents([.medium, .height(500)])
            })
    }
    
    var titleBar: some View {
        HStack {
            Label("食物清單", systemImage: "fork.knife")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.accent)
                .font(.title.bold())
            EditButton()
                .buttonStyle(.bordered)
            
        }.padding()
    }
    
    var addButton: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 50))
                .padding()
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .accent)
        })
    }
    
    var deleteButton: some View {
        Button(action: {
            foods = foods.filter { !selectedFood.contains($0.id) }
        }, label: {
            Text("刪除全部").font(.title.bold())
                .frame(maxWidth: .infinity)
                
        }).capluseButton(.roundedRectangle(radius: 6))
            .padding(.horizontal, 50)
    }
    
    
    func buildFloatButton() -> some View {
        ZStack {
            deleteButton.id(isEditing)
                .transition(.move(edge: .leading).combined(with: .opacity).animation(.easeInOut))
                .opacity(isEditing ? 1: 0)
            HStack {
                Spacer()
                addButton.id(isEditing).scaleEffect(isEditing ? 0 : 1) .opacity(isEditing ? 0: 1)
                    .animation(.easeInOut, value: isEditing)
            }
        }
    }
    
    func buildNutritionView(title: String, value: String) -> some View {
        GridRow {
            Text(title).gridCellAnchor(.leading)
            Text(value).gridCellAnchor(.trailing)
        }
    }
}



struct Preview_FoodListDemo: PreviewProvider {
    static var previews: some View {
        FoodListDemo()
    }
}

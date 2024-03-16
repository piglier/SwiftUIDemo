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
    @State private var isShowDetailSheet: Bool = false
    @State private var detialSheetHeight: CGFloat = FoodSheetHeight.defaultValue
    
    private var isEditing: Bool { editMode?.wrappedValue == .active }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            titleBar
            List($foods, editActions: .all, selection: $selectedFood) { $food in
                HStack {
                    Text(food.name).padding(.vertical, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                        .onTapGesture {
                        if isEditing { return }
                        isShowDetailSheet = true
                    }
                    if isEditing {
                        Image(systemName: "pencil")
                            .font(.title2.bold())
                            .foregroundStyle(.accent)
                    }
                }
                
            }
            .listStyle(.plain)
            .padding(.horizontal)
        }.background(.groupBg)
            .safeAreaInset(edge: .bottom, content: buildFloatButton)
            .sheet(isPresented: $isShowDetailSheet, content: {
                let food = foods[4]
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
                .padding(.vertical)
                .overlay(content: {
                    GeometryReader { proxy in
                        Color.clear.preference(key: FoodSheetHeight.self, value: proxy.size.height)
                    }
                })
                .onPreferenceChange(FoodSheetHeight.self, perform: { value in
                    detialSheetHeight = value
                })
                .presentationDetents([.height(detialSheetHeight)])
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
                addButton
                    .scaleEffect(isEditing ? 0 : 1)
                    .opacity(isEditing ? 0: 1)
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


extension FoodListDemo {
    private struct FoodSheetHeight: PreferenceKey {
        static var defaultValue: CGFloat = 300
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
}



struct Preview_FoodListDemo: PreviewProvider {
    static var previews: some View {
        FoodListDemo()
    }
}

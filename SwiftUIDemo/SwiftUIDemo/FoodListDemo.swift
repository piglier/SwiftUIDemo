//
//  FoodListDemo.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/3/3.
//

import SwiftUI


enum FoodSheet: View, Identifiable {
    case newFood((Food) -> Void)
    case editFood(Binding<Food>)
    case detailFood(Food)
    
    var id: UUID {
        switch self {
        case .newFood(_):
            return UUID()
        case .editFood(let binding):
            return binding.wrappedValue.id
        case .detailFood(let food):
            return food.id
        }
    }
    
    var body: some View {
        switch self {
        case .newFood(let onSubmit):
            FoodListDemo.FoodForm(food: .new, onSubmit: onSubmit)
        case .editFood(let binding):
            FoodListDemo.FoodForm(food: binding.wrappedValue) { food in
                binding.wrappedValue = food
            }
        case .detailFood(let food):
            FoodListDemo.DetailSheet(food: food)
        }
    }
}

struct FoodListDemo: View {
    @Environment(\.editMode) var editMode
    @State private var foods: [Food] = Food.examples
    @State private var selectedFoodIds = Set<Food.ID>()
    @State private var sheet: FoodSheet?
    
    private var isEditing: Bool { editMode?.wrappedValue == .active }
    
    var body: some View {
        VStack(alignment: .leading) {
            titleBar
            List($foods, editActions: .all, selection: $selectedFoodIds, rowContent: buildFoodRow)
            .listStyle(.plain)
            .padding(.horizontal)
        }.background(.groupBg)
            .safeAreaInset(edge: .bottom, content: buildFloatButton)
            .sheet(item: $sheet) { $0 }
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
        Button(action: {
            sheet = .newFood({ food in
                foods.append(food)
            })
        }, label: {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 50))
                .padding()
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .accent)
        })
    }
    
    var deleteButton: some View {
        Button(action: {
            foods = foods.filter { !selectedFoodIds.contains($0.id) }
        }, label: {
            Text("刪除已選擇項目").font(.title.bold())
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
    
    private func buildFoodRow(_ bindingFood: Binding<Food>) -> some View {
        HStack {
            Text(bindingFood.wrappedValue.name).padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    if isEditing {
                        selectedFoodIds.insert(bindingFood.id)
                        return
                    }
                    sheet = .detailFood(bindingFood.wrappedValue)
            }
            if isEditing {
                Image(systemName: "pencil")
                    .font(.title2.bold())
                    .foregroundStyle(.accent)
                    .onTapGesture {
                        sheet = .editFood(bindingFood)
                    }
            }
        }
    }
    
}


extension FoodListDemo {
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
        
        func buildNutritionView(title: String, value: String) -> some View {
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
            .overlay(content: {
                GeometryReader { proxy in
                    Color.clear.preference(key: FoodSheetHeight.self, value: proxy.size.height)
                }
            })
            .onPreferenceChange(FoodSheetHeight.self, perform: { value in
                detialSheetHeight = value
            })
            .presentationDetents([.height(detialSheetHeight)])
        }
    }
}



struct Preview_FoodListDemo: PreviewProvider {
    static var previews: some View {
        FoodListDemo()
    }
}

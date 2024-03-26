//
//  FoodListDemo.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/3/3.
//

import SwiftUI

struct FoodListScreen: View {
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
            .sheet(item: $sheet)
    }
    
    var titleBar: some View {
        HStack {
            Label("食物清單", sfSymbol: .knife)
                .push(to: .trailing)
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
            Image(sfSymbol: .plus)
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
                .maxWidth()
        }).capluseButton(.roundedRectangle(radius: 6))
            .padding(.horizontal, 50)
    }
            
    
    func buildFloatButton() -> some View {
        ZStack {
            deleteButton.id(isEditing)
                .transition(.moveleadingWithOpactiy.animation(.easeInOut))
                .opacity(isEditing ? 1: 0)
                addButton
                    .scaleEffect(isEditing ? 0 : 1)
                    .opacity(isEditing ? 0: 1)
                    .animation(.easeInOut, value: isEditing)
                    .push(to: .trailing)
        }
    }
    
    private func buildFoodRow(_ bindingFood: Binding<Food>) -> some View {
        HStack {
            Text(bindingFood.wrappedValue.name).padding(.vertical, 10)
                .push(to: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    if isEditing {
                        selectedFoodIds.insert(bindingFood.id)
                        return
                    }
                    sheet = .detailFood(bindingFood.wrappedValue)
            }
            if isEditing {
                Image(sfSymbol: .pencil)
                    .font(.title2.bold())
                    .foregroundStyle(.accent)
                    .onTapGesture {
                        sheet = .editFood(bindingFood)
                    }
            }
        }
    }
    
}






struct Preview_FoodListDemo: PreviewProvider {
    static var previews: some View {
        FoodListScreen()
    }
}

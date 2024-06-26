//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/2/18.
//

import SwiftUI
import CoreData


struct FoodPickerScreen: View {
    @State var selectedFood: Food?
    @State var shouldShowInfo: Bool = false
    
    let foods = Food.examples
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 30) {
                    selectFoodView
                    Text("今天吃什麼?")
                        .bold()
                    selectFoodInfo
                    Spacer().layoutPriority(1.0)
                    selectButton
                    resetButton
                }
                .padding()
                .frame(minHeight: proxy.size.height)
                .maxWidth()
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .mainButtonStyle()
                .animation(Animation.foodEaseInOut, value: selectedFood)
                .animation(Animation.foodSpring, value: shouldShowInfo)
            }.background(.bg2)
        }
    }
    
    var selectFoodView: some View {
        VStack(spacing: 30) {
            Group {
                if let selectedFood {
                    Text(selectedFood.image)
                        .font(.system(size: 200))
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                } else {
                    Image("dinner")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .frame(height: 250)
        }
    }
    
    @ViewBuilder var selectFoodInfo: some View {
        if let food = selectedFood {
            VStack {
                HStack {
                    Text(food.name)
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.green)
                        .id(food.name)
                        .transition(.delayInserion)
                    Button(action: {
                        shouldShowInfo.toggle()
                    }) {
                        Image(sfSymbol: .infoCircle)
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                }
                Text("熱量 \(food.$calorie.description)")
                    .font(.title2)
                VStack {
                    if (shouldShowInfo) {
                            Grid(horizontalSpacing: 40, verticalSpacing: 12) {
                                GridRow{
                                    Text("蛋白質")
                                    Text("脂肪")
                                    Text("碳水")
                                }.frame(minWidth: 60)
                                Divider()
                                    .gridCellUnsizedAxes(.horizontal)
                                    .padding(.horizontal, -10)
                                GridRow{
                                    Text(food.$protein.description)
                                    Text(food.$fat.description)
                                    Text(food.$carb.description)
                                }
                        }
                        .font(.title3)
                        .padding(.horizontal)
                        .padding()
                        .background(foodMainButton())
                        .transition(.foodTopOpacity)
                    }
                }.maxWidth().clipped()
                
            }
        }
    }
    
    var selectButton: some View {
        Button() {
            selectedFood = foods.shuffled().filter { $0 != selectedFood }.first
        } label: {
            Text(selectedFood == nil ? "告訴我" : "換一個")
                .frame(width: 200)
                .transformEffect(.identity)
        }
        .padding(.bottom, -15)
    }
    var resetButton: some View {
        Button() {
            selectedFood = .none
            shouldShowInfo = false
        } label: {
            Text("重置")
                .frame(width: 200)
        }
        .buttonStyle(.bordered)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FoodPickerScreen()
    }
}


extension FoodPickerScreen {
    init(selectedFood: Food) {
        _selectedFood = .init(wrappedValue: selectedFood)
    }
}

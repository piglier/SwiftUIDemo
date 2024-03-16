//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/2/18.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @State var selectedFood: Food?
    @State var shouldShowInfo: Bool = false
    
    let foods = Food.examples
    
    var body: some View {
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
            .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height - 100)
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .capluseButton()
            .animation(Animation.foodEaseInOut, value: selectedFood)
            .animation(Animation.foodSpring, value: shouldShowInfo)
        }.background(.bg2)
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
                        Image(systemName: "info.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                }
                Text("熱量 \(food.$calorie)")
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
                                    Text(food.$protein)
                                    Text(food.$fat)
                                    Text(food.$carb)
                                }
                        }
                        .font(.title3)
                        .padding(.horizontal)
                        .padding()
                        .background(foodMainButton())
                        .transition(.foodTopOpacity)
                    }
                }.frame(maxWidth: .infinity).clipped()
                
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
//        ContentView(selectedFood: Food.examples.first!)
        ContentView(selectedFood: Food.examples.first!).previewDevice(.iPad)
        ContentView(selectedFood: Food.examples.first!).previewDevice(.iPhoneSE)
    }
}


extension ContentView {
    init(selectedFood: Food) {
        _selectedFood = .init(wrappedValue: selectedFood)
    }
}

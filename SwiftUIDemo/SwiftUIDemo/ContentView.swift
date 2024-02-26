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
                Group {
                    if (selectedFood == .none) {
                        Image("dinner")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else {
                        Text(selectedFood!.image)
                            .font(.system(size: 200))
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                    }
                }
                .frame(height: 250)
                Text("今天吃什麼?")
                    .bold()
                
                if let food = selectedFood {
                    VStack {
                        HStack {
                            Text(food.name)
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(.green)
                                .id(food.name)
                                .transition(.asymmetric(
                                    insertion: .opacity.animation(.easeInOut(duration: 0.5).delay(0.2)),
                                    removal: .opacity.animation(.easeInOut(duration: 0.4))
                                ))
                            Button(action: {
                                shouldShowInfo.toggle()
                            }) {
                                Image(systemName: "info.circle.fill")
                                    .foregroundStyle(.secondary)
                            }
                            .buttonStyle(.plain)
                        }
                        Text("熱量 \(food.calorie.formatted()) 大卡")
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
                                        Text(food.protein.formatted())
                                        Text(food.fat.formatted() + " g")
                                        Text(food.$carb)
                                    }
                                }
                                .font(.title3)
                                .padding(.horizontal)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(Color(.systemBackground)))
                                .transition(.move(edge: .top).combined(with: .opacity))
                            }
                        }.frame(maxWidth: .infinity).clipped()
                        
                    }
                }
                Spacer().layoutPriority(1.0)
                Button() {
                    selectedFood = foods.shuffled().filter { $0 != selectedFood }.first
                } label: {
                    Text(selectedFood == nil ? "告訴我" : "換一個")
                        .frame(width: 200)
                        .transformEffect(.identity)
                }
                .padding(.bottom, -15)
                
                Button() {
                    selectedFood = .none
                    shouldShowInfo = false
                } label: {
                    Text("重置")
                        .frame(width: 200)
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height - 100)
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .animation(.easeInOut(duration: 0.5), value: selectedFood)
            .animation(.spring(dampingFraction: 0.5), value: shouldShowInfo)
        }.background(Color(.secondarySystemBackground))
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedFood: Food.examples.first!)
        ContentView(selectedFood: Food.examples.first!).previewDevice(.iPad)
        ContentView(selectedFood: Food.examples.first!).previewDevice(.iPhoneSE)
    }
}


extension ContentView {
    init(selectedFood: Food) {
        _selectedFood = .init(wrappedValue: selectedFood)
    }
}

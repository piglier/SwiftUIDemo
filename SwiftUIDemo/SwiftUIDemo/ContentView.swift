//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/2/18.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let foods = Food.examples
    @State var selectedFood: Food?
    
    var body: some View {
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
            Spacer()
            if let food = selectedFood {
                Text(food.name)
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.green)
                    .id(selectedFood?.name)
                    .transition(.asymmetric(
                        insertion: .opacity.animation(.easeInOut(duration: 0.5).delay(0.2)),
                        removal: .opacity.animation(.easeInOut(duration: 0.4))
                    ))
                    
            }
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
            } label: {
                Text("重置")
                    .frame(width: 200)
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.secondarySystemBackground))
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .animation(.easeInOut(duration: 0.5), value: selectedFood)
    }
    
}

//#Preview {
//    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

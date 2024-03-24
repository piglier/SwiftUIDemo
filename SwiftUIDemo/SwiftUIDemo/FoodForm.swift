//
//  FoodForm.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/3/16.
//

import SwiftUI

private enum FoodFormField: Int { case name, image, calorie, protein, fat, carb }

private extension TextField where Label == Text {
    func focus(field: FocusState<FoodFormField?>.Binding, value: FoodFormField) -> some View {
        submitLabel(value == .carb ? .done : .next)
            .focused(field, equals: value)
            .onSubmit {
                field.wrappedValue = .init(rawValue: value.rawValue + 1)
            }
    }
}

extension FoodListDemo {
    
    struct FoodForm: View {
        
        @Environment(\.dismiss) var dismiss
        @State var food: Food
        private var disableSave: Bool {
            food.name.isEmpty || food.image.count > 2
        }
        @FocusState private var field: FoodFormField?
        
        private var inVaildMsg: String? {
            if food.name.isEmpty { return "請輸入品名" }
            if food.image.count > 2 { return "圖片字數不可多過2個" }
            return .none
        }
        
        var onSubmit: (Food) -> Void?
        
        var body: some View {
            NavigationStack {
                VStack {
                    HStack{
                        Label("編輯食物資訊", systemImage: "pencil")
                            .foregroundStyle(.accent)
                            .font(.title)
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                            .font(.largeTitle)
                            .onTapGesture {
                                dismiss()
                            }
                    }.padding([.horizontal, .top])
                    
                    Form {
                        LabeledContent("品名") {
                            TextField("必填", text: $food.name)
                                .focus(field: $field, value: .name)
                        }
                        LabeledContent("圖示") {
                            TextField("最多數入兩個字元", text: $food.image)
                                .submitLabel(.next)
                                .focused($field, equals: .image)
                        }
                        buildNutricContent(title: "熱量", num: $food.calorie, unit: "熱量", focus: .calorie)
                        buildNutricContent(title: "蛋白質", num: $food.protein, focus: .protein)
                        buildNutricContent(title: "脂肪", num: $food.fat, focus: .fat)
                        buildNutricContent(title: "碳水", num: $food.carb, focus: .carb)
                    }.padding(.top, -16)
                    Button{
                        dismiss()
                        onSubmit(food)
                    } label: {
                        Text(inVaildMsg ?? "儲存")
                            .bold()
                            .frame(maxWidth: .infinity)
                    }
                    .capluseButton()
                    .padding()
                    .disabled(disableSave)
                }
                .background(.groupBg)
                .multilineTextAlignment(.trailing)
                .scrollDismissesKeyboard(.immediately)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button(action: goPreviousField) { Image(systemName: "chevron.up") }
                        Button(action: goNextField) { Image(systemName: "chevron.down") }
                    }
                }
            }
        }
        
        private func goPreviousField() {
            if let field {
                self.field = FoodFormField(rawValue: field.rawValue - 1)
            }
            
        }
        private func goNextField() {
            if let field {
                self.field = FoodFormField(rawValue: field.rawValue + 1)
            }
        }
        
        
        private func buildNutricContent(title: String, num: Binding<Double>, unit: String = "g", focus: FoodFormField) -> some View {
            LabeledContent(title) {
                TextField("", value: num, format: .number.precision(.fractionLength(1)))
//                    .focus(field: $field, value: focus)
                    .keyboardType(.decimalPad)
                    .focused($field, equals: focus)
                Text(unit)
            }
        }
    }
    
    
}


struct Preview_FoodFrom: PreviewProvider {
    static var previews: some View {
        FoodListDemo.FoodForm(food: Food.examples.first!) { _ in }
    }
}


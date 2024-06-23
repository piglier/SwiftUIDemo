//
//  FoodForm.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/3/16.
//

import SwiftUI

enum FoodFormField: Int { case name, image, calorie, protein, fat, carb }

private extension TextField where Label == Text {
    func focus(field: FocusState<FoodFormField?>.Binding, value: FoodFormField) -> some View {
        submitLabel(value == .carb ? .done : .next)
            .focused(field, equals: value)
            .onSubmit {
                field.wrappedValue = .init(rawValue: value.rawValue + 1)
            }
    }
}

extension FoodListScreen { 
    
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
                    titleBar
                    formView
                    saveButton
                }
                .background(.groupBg)
                .multilineTextAlignment(.trailing)
                .scrollDismissesKeyboard(.immediately)
                .toolbar(content: buildKeyboardTools)
            }
        }
    }
}


// MARK: Subviews
extension FoodListScreen.FoodForm {
    
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
    
    private func buildKeyboardTools() -> some ToolbarContent {
        ToolbarItemGroup(placement: .keyboard) {
            Spacer()
            Button(action: goPreviousField) { Image(sfSymbol: .chevronUp)}
            Button(action: goNextField) { Image(sfSymbol: .chevronDown) }
        }
    }
    
    private var titleBar: some View {
        HStack{
            Label("編輯食物資訊", systemImage: .pencil)
                .foregroundStyle(.accent)
                .font(.title)
            Image(sfSymbol: .xmarkCircle)
                .foregroundStyle(.secondary)
                .font(.largeTitle)
                .onTapGesture {
                    dismiss()
                }
        }.padding([.horizontal, .top])
    }
    
    
    func buildNutricContent<Unit: MyUnitProtocol & Hashable>(title: String, value: Binding<Suffix<Unit>>, field: FoodFormField) -> some View {
        LabeledContent(title) {
            HStack {
                TextField(
                    "",
                    value: Binding(
                        get: { value.wrappedValue.wrappedValue },
                        set: { value.wrappedValue.wrappedValue = $0 }
                    ),
                    format: .number.precision(.fractionLength(1)))
                    .focused($field, equals: field)
                    .keyboardType(.decimalPad)
                if (Unit.allCases.count <= 1) {
                    value.unit.wrappedValue.font(.body)
                } else {
                    Picker("單位", selection: value.unit) {
                        ForEach(Unit.allCases)
                    }.labelsHidden()
                }
            }
        }
    }
    
    private var formView: some View {
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
            buildNutricContent(title: "熱量", value: $food.$calorie, field: .calorie)
            buildNutricContent(title: "蛋白質", value: $food.$protein, field: .protein)
            buildNutricContent(title: "脂肪", value: $food.$fat, field: .fat)
            buildNutricContent(title: "碳水", value: $food.$carb, field: .carb)
        }.padding(.top, -16)
    }
    
    private var saveButton: some View {
        Button{
            dismiss()
            onSubmit(food)
        } label: {
            Text(inVaildMsg ?? "儲存")
                .bold()
                .maxWidth()
        }
        .capluseButton()
        .padding()
        .disabled(disableSave)
    }
}


struct Preview_FoodFrom: PreviewProvider {
    static var previews: some View {
        FoodListScreen.FoodForm(food: Food.examples.first!) { _ in }
    }
}


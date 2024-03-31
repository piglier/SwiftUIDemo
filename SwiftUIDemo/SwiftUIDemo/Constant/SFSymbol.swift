//
//  SFSymbol.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/3/24.
//

import SwiftUI


enum SFSymbol: String {
    case chevronDown = "chevron.down"
    case chevronUp = "chevron.up"
    case gear = "gearshape"
    case house = "house.fill"
    case infoCircle = "info.circle.fill"
    case knife = "fork.knife"
    case list = "list.bullet"
    case moon = "moon.fill"
    case unitSign = "numbersign"
    case plus = "plus.circle.fill"
    case pencil
    case xmarkCircle = "xmark.circle.fill"
}


extension Label where Title == Text, Icon == Image {
    init(_ text: String, systemImage: SFSymbol) {
        self.init(text, systemImage: systemImage.rawValue)
    }
}


extension Image {
    init(sfSymbol: SFSymbol) {
        self.init(systemName: sfSymbol.rawValue)
    }
}

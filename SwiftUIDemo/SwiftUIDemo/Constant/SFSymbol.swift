//
//  SFSymbol.swift
//  SwiftUIDemo
//
//  Created by 朱彥睿 on 2024/3/24.
//

import SwiftUI


enum SFSymbol: String {
    case chevronUp = "chevron.up"
    case xmarkCircle = "xmark.circle.fill"
    case infoCircle = "info.circle.fill"
    case chevronDown = "chevron.down"
    case plus = "plus.circle.fill"
    case pencil
    case knife = "fork.knife"
}


extension Label where Title == Text, Icon == Image {
    init(_ text: String, sfSymbol: SFSymbol) {
        self.init(text, systemImage: sfSymbol.rawValue)
    }
}


extension Image {
    init(sfSymbol: SFSymbol) {
        self.init(systemName: sfSymbol.rawValue)
    }
}

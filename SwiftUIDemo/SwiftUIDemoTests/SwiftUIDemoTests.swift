//
//  SwiftUIDemoTests.swift
//  SwiftUIDemoTests
//
//  Created by 朱彥睿 on 2024/4/5.
//

import XCTest
import SwiftUI
@testable import SwiftUIDemo

private let store: UserDefaults = UserDefaults(suiteName: #file)!


final class SwiftUIDemoTests: XCTestCase {
    var sut: Suffix<MyWeightUnit> = .init(wrappedValue: .zero, .defaultUnit, store: store)
    @AppStorage(.preferredWeightUnit, store: store) var preferredUnit: MyWeightUnit
    
    
    override class func setUp() {
        super.setUp()
        UserDefaults.standard.removePersistentDomain(forName: #file)
    }
    
    // 測試命名 convention(慣用法)
    // test_主體_情況_結果
    
    // Arrage Act Assert 設定 變化 判斷
    
    func testJoinNumberAndSuffix() {
        sut.wrappedValue = 100.1
        sut.unit = .g
        XCTAssertEqual(sut.description, "100.1 grams")
    }
    
    func testNumberFormatter_preferredPounds() {
        preferredUnit = .pounds
        
        sut.wrappedValue = 100
        sut.unit = .g 
        XCTAssertEqual(sut.description, "0.2 pounds")
        
        sut.wrappedValue = -300
        sut.unit = .g 
        XCTAssertEqual(sut.description, "-0.7 pounds")
        
        sut.wrappedValue = 453.592
        sut.unit = .g
        XCTAssertEqual(sut.description, "1 pounds")
    }
    
    func testFormatter() throws {
        // test_formattedString_suffixIsEmpty_shouldNotIncludedSpace
        // Arrage 設定
        //sut = .init(wrappedValue: 100, .g)

        // Act 變化
        //let result = sut.projectedValue.description
        
        // Assert 判斷
        //XCTAssertEqual(result, "100")
        sut.wrappedValue = 100
        sut.unit = .g
        XCTAssertEqual(sut.description, "100 grams", "Suffix被用壞了")
        
        sut.wrappedValue = 100.678
        sut.unit = .g
        XCTAssertEqual(sut.description, "100.7 grams")
        
        sut.wrappedValue = 100.611
        sut.unit = .g
        XCTAssertEqual(sut.description, "100.6 grams")
        
        sut.wrappedValue = -100.681
        sut.unit = .g
        XCTAssertEqual(sut.description, "-100.7 grams")
        
// 暫時修改的測試可以XCTXCTExpectFailure來by pass
//        XCTExpectFailure("還沒實作精準度設計, 待後續處理小數點後的四捨五入") {
//            XCTAssertEqual(sut.projectedValue, "100.7 ")
//        }
    }

}

//
//  SwiftUIDemoTests.swift
//  SwiftUIDemoTests
//
//  Created by 朱彥睿 on 2024/4/5.
//

import XCTest
@testable import SwiftUIDemo


final class SwiftUIDemoTests: XCTestCase {
    var sut: Suffix!
    
    // 測試命名 convention(慣用法)
    // test_主體_情況_結果
    
    // Arrage Act Assert 設定 變化 判斷
    
    
    
    func testFormatter() throws {
        // test_formattedString_suffixIsEmpty_shouldNotIncludedSpace
        // Arrage 設定
        sut = .init(wrappedValue: 100, "")
        
        // Act 變化
        let result = sut.projectedValue
        
        // Assert 判斷
        XCTAssertEqual(result, "100")
        
        XCTAssertEqual(sut.projectedValue, "100", "沒有後綴時不應該有空白")
        
        
        
        sut = .init(wrappedValue: 100.0, "g")
        XCTAssertEqual(sut.projectedValue, "100 g", "Suffix被用壞了")
        
        sut = .init(wrappedValue: 100.1, "大卡")
        XCTAssertEqual(sut.projectedValue, "100.1 大卡")
        
        sut = .init(wrappedValue: 100.1, "大卡")
        XCTAssertEqual(sut.projectedValue, "100.1 大卡")
        
        sut = .init(wrappedValue: 100.678, "g")
        XCTAssertEqual(sut.projectedValue, "100.7 g")
        
        sut = .init(wrappedValue: 100.611, "g")
        XCTAssertEqual(sut.projectedValue, "100.6 g")
        
        sut = .init(wrappedValue: -100.681, "g")
        XCTAssertEqual(sut.projectedValue, "-100.7 g")
        
// 暫時修改的測試可以XCTXCTExpectFailure來by pass
//        XCTExpectFailure("還沒實作精準度設計, 待後續處理小數點後的四捨五入") {
//            XCTAssertEqual(sut.projectedValue, "100.7 ")
//        }
    }

}

//
//  SwiftExpressionTests.swift
//  SwiftExpressionTests
//
//  Created by Joshua Alvarado on 7/31/16.
//  Copyright © 2016 Joshua Alvarado. All rights reserved.
//

import XCTest
@testable import SwiftExpression

class SwiftExpressionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // MARK: - Prefix test
    
    func testPrefixOperator() {
        if let regex = <>"regex" {
            XCTAssertEqual(regex.toString(), "regex")
        } else {
            assertionFailure("Prefix failed to create Regex")
        }
    }
    
    // MARK: - Infix test

    func testInfixOperator() {
        XCTAssertEqual("Hello World" =~ "Hello World", true)
        XCTAssertNotEqual("Hello World" =~ "hello world", true)
        
        if let regex = Regex(pattern: "[A-Z]") {
            XCTAssertTrue("ABC" =~ regex)
        } else {
            XCTFail("Regex failed to init")
        }
        
        XCTAssertTrue("www" =~ "www")
        
        XCTAssertFalse("123" =~ "[a-z]")
    }
    
    // MARK: - Regex match test
    
    func testIntegerAndDecimalRegex() {
        let intAndDecRegexStr = "(?:\\d*\\.)?\\d+"
        let numberStr = "10rats + .36geese = 3.14cows"
        
        // the string results that should be returned
        let matchesTest = ["10", ".36", "3.14"]
        
        if let regex = Regex(pattern: intAndDecRegexStr) {
            XCTAssertEqual(regex.toString(), intAndDecRegexStr)
            let match = numberStr.match(regex)
            XCTAssertEqual(match.components.count, 3)
            for (index, testMatch) in matchesTest.enumerate() {
                if index < match.subStrings().count {
                    XCTAssertEqual(match.subStrings()[index].compare(testMatch, options: .LiteralSearch, range: nil, locale: nil), NSComparisonResult.OrderedSame)
                } else {
                    XCTFail(#function + "Test matches index greater than matches returned from Regex")
                }
            }
        } else {
            XCTFail("Regex failed to init")
        }
    }
    
    func testTestingRegex() {
        let testingRegexStr = "\\btest(er|ing|ed|s)?\\b"
        let testStr = "that tested test is testing the tester's tests"
        
        // the string results that should be returned
        let matchesTest = ["tested", "test", "testing", "tester", "tests"]
        
        if let regex = Regex(pattern: testingRegexStr) {
            XCTAssertEqual(regex.toString(), testingRegexStr)
            let match = testStr.match(regex)
            XCTAssertEqual(match.components.count, matchesTest.count)
            for (index, testMatch) in matchesTest.enumerate() {
                if index < match.subStrings().count {
                    XCTAssertEqual(match.subStrings()[index].compare(testMatch, options: .LiteralSearch, range: nil, locale: nil), NSComparisonResult.OrderedSame)
                } else {
                    XCTFail(#function + "Test matches index greater than matches returned from Regex")
                }
            }
        } else {
            XCTFail("Regex failed to init")
        }
    }
    
    func testPhoneNumberRegex() {
        let phoneNumRegexStr = "\\b\\d{3}[-.]?\\d{3}[-.]?\\d{4}\\b"
        let testStr = "p:444-555-1234 f:246.555.8888 m:1235554567"

        // the string results that should be returned
        let matchesTest = ["444-555-1234", "246.555.8888", "1235554567"]
        
        if let regex = Regex(pattern: phoneNumRegexStr) {
            XCTAssertEqual(regex.toString(), phoneNumRegexStr)
            let match = testStr.match(regex)
            XCTAssertEqual(match.components.count, matchesTest.count)
            for (index, testMatch) in matchesTest.enumerate() {
                if index < match.subStrings().count {
                    XCTAssertEqual(match.subStrings()[index].compare(testMatch, options: .LiteralSearch, range: nil, locale: nil), NSComparisonResult.OrderedSame)
                } else {
                    XCTFail(#function + "Test matches index greater than matches returned from Regex")
                }
            }
        } else {
            XCTFail("Regex failed to init")
        }
    }
    
    func testWordsRegex() {
        let wordsRegexStr = "[a-zA-Z]+"
        let testStr = "RegEx is tough, but useful."
        
        // the string results that should be returned
        let matchesTest = ["RegEx", "is", "tough", "but", "useful"]
        
        if let regex = Regex(pattern: wordsRegexStr) {
            XCTAssertEqual(regex.toString(), wordsRegexStr)
            let match = testStr.match(regex)
            XCTAssertEqual(match.components.count, matchesTest.count)
            for (index, testMatch) in matchesTest.enumerate() {
                if index < match.subStrings().count {
                    XCTAssertEqual(match.subStrings()[index].compare(testMatch, options: .LiteralSearch, range: nil, locale: nil), NSComparisonResult.OrderedSame)
                } else {
                    XCTFail(#function + "Test matches index greater than matches returned from Regex")
                }
            }
        } else {
            XCTFail("Regex failed to init")
        }
    }
    
    func testFourLetterWordRegex() {
        let foundLetterWordRegexStr = "\\b\\w{4}\\b"
        let testStr = "drink beer, it's very nice!"
        
        // the string results that should be returned
        let matchesTest = ["beer", "very", "nice"]
        
        if let regex = Regex(pattern: foundLetterWordRegexStr) {
            XCTAssertEqual(regex.toString(), foundLetterWordRegexStr)
            let match = testStr.match(regex)
            XCTAssertEqual(match.components.count, matchesTest.count)
            for (index, testMatch) in matchesTest.enumerate() {
                if index < match.subStrings().count {
                    XCTAssertEqual(match.subStrings()[index].compare(testMatch, options: .LiteralSearch, range: nil, locale: nil), NSComparisonResult.OrderedSame)
                } else {
                    XCTFail(#function + "Test matches index greater than matches returned from Regex")
                }
            }
        } else {
            XCTFail("Regex failed to init")
        }
    }
    
    func testRanges() {
        let str = "HelloWorldH"
        let pattern = "[A-Z]"
        if let regex = Regex(pattern: pattern) {
            let match = str.match(regex)
            XCTAssertEqual(match.ranges().count, 3)
        }
    }
    
    // MARK: - Regex replace test
    
    func testReplacingString() {
        let foundLetterWordRegexStr = "\\b\\w{4}\\b"
        let testStr = "drink beer, it's very nice!"
        if let regex = Regex(pattern: foundLetterWordRegexStr) {
            let replacementString = testStr.replace(regex, withString: "")
            XCTAssertEqual(replacementString, "drink , it's  !")
        } else {
            XCTFail("Regex failed to init")
        }
    }
    
    // MARK: - Regex replace test

    func testSearchWord() {
        let str = "HelloWorldApp"
        if let regex = Regex(pattern: "App") {
            XCTAssertEqual(str.search(regex), 10)
        } else {
            XCTFail("Regex failed to init")
        }
    }
    
    func testSearchDigit() {
        let str = "HelloWorldApp123"
        if let regex = Regex(pattern: "\\d") {
            XCTAssertEqual(str.search(regex), 13)
        } else {
            XCTFail("Regex failed to init")
        }
    }
    
    func testFalseSearch() {
        let str = "abcefghij"
        if let regex = Regex(pattern: "\\d") {
            XCTAssertNil(str.search(regex))
        } else {
            XCTFail("Regex failed to init")
        }
    }
}

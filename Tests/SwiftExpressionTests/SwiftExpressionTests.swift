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

    static var allTests = [
        (testPrefixOperator, "testPrefixOperator"),
        (testInvalidPattern, "testInvalidPattern"),
        (testRegexToString, "testRegexToString"),
        (testInfixOperator, "testInfixOperator"),
        (testIntegerAndDecimalRegex, "testIntegerAndDecimalRegex"),
        (testTestingRegex, "testTestingRegex"),
        (testPhoneNumberRegex, "testPhoneNumberRegex"),
        (testWordsRegex, "testWordsRegex"),
        (testFourLetterWordRegex, "testFourLetterWordRegex"),
        (testRanges, "testRanges"),
        (testCaseInsensitiveMatch, "testCaseInsensitiveMatch"),
        (testNSRegularExpressionInitMatch, "testNSRegularExpressionInitMatch"),
        (testReplacingString, "testReplacingString"),
        (testFindDigits, "testFindDigits"),
        (testFalseSearch, "testFalseSearch"),
        (testMatchWithExtendedUTF, "testMatchWithExtendedUTF"),
        (testMatchWithEmoji, "testMatchWithEmoji"),
    ]

    let bigString = "bbbbbcccsqwerqweriuqwenfikewjrnwlierngwrieunebbbbbcccsqwerqweriuqwenfikewjrnwlierngwrieunebbbbbcccsqwerqweriuqwenfikewjrnwlierngwrieunebbbbbcccsqwerqweriuqweanfikewjrnwlierngwrieunebbbbbcccsqwerqweriuqwenfikewjrnwlierngwrieunebbbbbcccsqwerqweriuqwenfikewjrnwlierngwrieun"

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testFindPerformance() {
        let pattern = "a"

        measure {
            if let regex = <>pattern {
                XCTAssertTrue(regex.find(in: self.bigString))
            } else {
                XCTFail("Failed to init regex with pattern: \(pattern)")
            }
        }
    }

    func testMatchesPerformance() {
        let pattern = "[a-zA-Z]"

        measure {
            if let regex = Regex(pattern: pattern) {
                let matches = self.bigString.match(regex)
                XCTAssertEqual(matches.components.count, 270)
            } else {
                XCTFail("Failed to init regex with pattern: \(pattern)")
            }
        }
    }

    // MARK: - Prefix test

    func testPrefixOperator() {
        if let regex = <>"regex" {
            XCTAssertEqual(regex.pattern, "regex")
        } else {
            assertionFailure("Prefix failed to create Regex")
        }
    }

    func testInvalidPattern() {
        let emptyPattern = ""
        XCTAssertNil(Regex(pattern: emptyPattern))
    }

    func testRegexToString() {
        let pattern = "[a-zA-Z]"

        if let regex = Regex(pattern: pattern) {
            XCTAssertEqual(regex.pattern, pattern)
        } else {
            XCTFail("Failed to init regex with pattern: \(pattern)")
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
        XCTAssertFalse("123" =~ "")
    }

    // MARK: - Regex match test

    func testIntegerAndDecimalRegex() {
        let intAndDecRegexStr = "(?:\\d*\\.)?\\d+"
        let numberStr = "10rats + .36geese = 3.14cows"

        // the string results that should be returned
        let matchesTest = ["10", ".36", "3.14"]

        if let regex = Regex(pattern: intAndDecRegexStr) {
            XCTAssertEqual(regex.pattern, intAndDecRegexStr)
            let match = numberStr.match(regex)
            XCTAssertEqual(match.components.count, 3)
            for (index, testMatch) in matchesTest.enumerated() {
                if index < match.subStrings().count {
                    XCTAssertEqual(match.subStrings()[index].compare(testMatch, options: .literal, range: nil, locale: nil), ComparisonResult.orderedSame)
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
            XCTAssertEqual(regex.pattern, testingRegexStr)
            let match = testStr.match(regex)
            XCTAssertEqual(match.components.count, matchesTest.count)
            for (index, testMatch) in matchesTest.enumerated() {
                if index < match.subStrings().count {
                    XCTAssertEqual(match.subStrings()[index].compare(testMatch, options: .literal, range: nil, locale: nil), ComparisonResult.orderedSame)
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
            XCTAssertEqual(regex.pattern, phoneNumRegexStr)
            let match = testStr.match(regex)
            XCTAssertEqual(match.components.count, matchesTest.count)
            for (index, testMatch) in matchesTest.enumerated() {
                if index < match.subStrings().count {
                    XCTAssertEqual(match.subStrings()[index].compare(testMatch, options: .literal, range: nil, locale: nil), ComparisonResult.orderedSame)
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
            XCTAssertEqual(regex.pattern, wordsRegexStr)
            let match = testStr.match(regex)
            XCTAssertEqual(match.components.count, matchesTest.count)
            for (index, testMatch) in matchesTest.enumerated() {
                if index < match.subStrings().count {
                    XCTAssertEqual(match.subStrings()[index].compare(testMatch, options: .literal, range: nil, locale: nil), ComparisonResult.orderedSame)
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
            XCTAssertEqual(regex.pattern, foundLetterWordRegexStr)
            let match = testStr.match(regex)
            XCTAssertEqual(match.components.count, matchesTest.count)
            for (index, testMatch) in matchesTest.enumerated() {
                if index < match.subStrings().count {
                    XCTAssertEqual(match.subStrings()[index].compare(testMatch, options: .literal, range: nil, locale: nil), ComparisonResult.orderedSame)
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
        } else {
            XCTFail("Regex failed to init")
        }
    }

    func testCaseInsensitiveMatch() {
        let str = "aBc"
        let pattern = "abc"

        if let caseInsensitiveRegex = Regex(pattern: pattern, options: .caseInsensitive) {
            XCTAssertFalse(caseInsensitiveRegex.matches(in: str).components.isEmpty)
        } else {
            XCTFail("Regex failed to init")
        }

        if let caseSensitiveRegex = Regex(pattern: pattern) {
            XCTAssertTrue(caseSensitiveRegex.matches(in: str).components.isEmpty)
        } else {
            XCTFail("Regex failed to init")
        }
    }

    func testNSRegularExpressionInitMatch() {
        let expression = try! NSRegularExpression(pattern: "\\w")
        let regex = Regex(expression: expression)
        let text = "abc"
        let matches = text.match(regex)
        XCTAssertEqual(matches.components.count, 3)
    }

    // MARK: - Regex replace test

    func testReplacingString() {
        let foundLetterWordRegexStr = "\\b\\w{4}\\b"
        let testStr = "drink beer, it's very nice!"
        if let regex = Regex(pattern: foundLetterWordRegexStr) {
            let replacementString = testStr.replace(regex, with: "")
            XCTAssertEqual(replacementString, "drink , it's  !")
        } else {
            XCTFail("Regex failed to init")
        }
    }

    // MARK: - Regex replace test

    func testFindDigits() {
        let str = "HelloWorldApp123"
        if let regex = Regex(pattern: "\\d") {
            XCTAssertTrue(str.find(regex))
        } else {
            XCTFail("Regex failed to init")
        }
    }

    func testFalseSearch() {
        let str = "abcefghij"
        if let regex = Regex(pattern: "\\d") {
            XCTAssertFalse(str.find(regex))
        } else {
            XCTFail("Regex failed to init")
        }
    }

    func testMatchWithExtendedUTF() {
        let text = "hello \u{1F525} world."
        let regex = Regex(pattern:"world")!
        let matches = text.match(regex)
        XCTAssertTrue(matches.subStrings().count == 1)
        XCTAssertTrue(matches.subStrings().first == "world")
    }

    func testMatchWithEmoji() {
        let text = "hello 🔥 world."
        let regex = Regex(pattern:"\u{1F525}")!
        let matches = text.match(regex)
        XCTAssertTrue(matches.subStrings().count == 1)
        XCTAssertTrue(matches.subStrings().first == "🔥")
    }
}

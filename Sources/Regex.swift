//
//  Regex.swift
//  SwiftExpression
//
//  Created by Joshua Alvarado on 7/31/16.
//  Copyright © 2016 Joshua Alvarado. All rights reserved.
//

import Foundation

/**
 Regex is a struct that is built off of `NSRegularExpression` to pattern match with. It is to be used to work with Regular Expression with `Strings`. Please refer to `NSRegularExpression` for the regular expression characters and [http://userguide.icu-project.org/strings/regexp](http://userguide.icu-project.org/strings/regexp) for ICU regular expressions.
 */
public struct Regex {

    /// Returns the `NSRegularExpression class used to apply regular expressions to strings.
    public let expression: NSRegularExpression

    /// Regex pattern used to match.
    public let pattern: String

    /// The `Match` struct holds the values of a regex match from pattern matching with a string. Uses its methods to access different values of the matching result.
    public struct Match {
        /// A collection of a tuple object with a value of the substring and the range of that substring from the string it was matched in/
        public let components: [(String, Range<String.Index>)]

        ///  A collection of just the substrings that were found in the match.
        public func subStrings() -> [String] {
            return components.map {
                $0.0
            }
        }

        ///  A collection of just the substring ranges that were found in the match.
        public func ranges() -> [Range<String.Index>] {
            return components.map {
                $0.1
            }
        }
    }

    /**
     Initializes an instance of `Regex` object with a regular expression pattern.

     - parameter pattern: The regular expression pattern
     */
    public init?(pattern: String, options: NSRegularExpression.Options = []) {
        do {
            self.expression = try NSRegularExpression(pattern: pattern, options: options)
            self.pattern = expression.pattern
        } catch {
            return nil
        }
    }

    /**
     Initializes an instance of `Regex` object with a NSRegularExpression object.

     - parameter expression: A `NSRegularExpression` class that is used to represent and apply regular expressions to strings.
     */
    public init(expression: NSRegularExpression) {
        self.expression = expression
        self.pattern = expression.pattern
    }

    /**
     Finds regex matches in a string.
     - Parameter in: the `String` to find matches in
     - Returns: A `Match` based on the matching result
     */
    public func matches(in str: String) -> Match {
        let length = str.characters.distance(from: str.startIndex, to: str.endIndex)
        let range = NSRange(location: 0, length: length)
        let results = expression.matches(in: str, range: range)

        var components = [(String, Range<String.Index>)]()
        results.forEach {
            if let stringRange = str.range(from: $0.range) {
                components.append((str.substring(with: stringRange), stringRange))
            }
        }

        return Match(components: components)
    }

    /**
     Replaces regex matches in string.
     - Parameter str: the `String` to find matches in
     - Parameter with: The substitution `String` used when replacing matching
     - Returns: A new `String` with the matches replaced
     */
    public func replaceMatches(in str: String, with template: String) -> String {
        let length = str.characters.distance(from: str.startIndex, to: str.endIndex)
        let range = NSRange(location: 0, length: length)
        return expression.stringByReplacingMatches(in: str, range: range, withTemplate: template)
    }

    /**
     Searches the string to find a match.
     - Parameter in: the `String` to find a match in
     - Returns: `true` if a match is found in the string
     */
    public func find(in str: String) -> Bool {
        let length = str.characters.distance(from: str.startIndex, to: str.endIndex)
        let range = NSRange(location: 0, length: length)
        return expression.firstMatch(in: str, options: [], range: range) != nil
    }
}

prefix operator <>

/**
 Initializes an instance of `Regex` object with a regular expression pattern.

 - parameter pattern: The regular expression pattern
 */
public prefix func <> (pattern: String) -> Regex? {
    return Regex(pattern: pattern)
}

infix operator =~

/**
 Find if regex pattern exists in string

 - parameters:
 - input: `String` to search in
 - regex: `Regex` object with defined pattern
 - returns: `true` if a pattern is found in the input string
 */
public func =~ (input: String, regex: Regex) -> Bool {
    return regex.find(in: input)
}

/**
 Find if regex pattern exists in string

 - parameters:
 - input: `String` to search in
 - regexPattern: regex pattern string
 - returns: `true` if a pattern is found in the input string
 */
public func =~ (input: String, regexPattern: String) -> Bool {
    if let regex = Regex(pattern: regexPattern) {
        return regex.find(in: input)
    }
    return false
}

extension String {
    /**
     Finds regex matches in the string. This method will find multiple matches in the string.
     - Parameter regex: `Regex` object that holds the pattern to find matches with
     - Returns: A `Match` based on the matching result
     */
    public func match(_ regex: Regex) -> Regex.Match {
        return regex.matches(in: self)
    }

    /**
     Finds regex matches in the string and replaces those matches with the replacement string.
     - Parameter regex: `Regex` object that holds the pattern to find matches with
     - Parameter with: The replacement `String` to insert in place of the match
     - Returns: A new `String` with the replacements applied
     */
    public func replace(_ regex: Regex, with str: String) -> String {
        return regex.replaceMatches(in: self, with: str)
    }

    /**
     Searches the string to find a match.
     - Parameter regex: `Regex` object that holds the pattern to find matches with
     - Returns: `true` if a match is found
     */
    public func find(_ regex: Regex) -> Bool {
        return regex.find(in: self)
    }

    /**
     Converts an NSRange to a String index range account for extended grapheme clusters.
     - Parameter range: The `NSRange` to convert to a String.Index range
     - Returns: nil if the range fails to convert
     - Note: https://stackoverflow.com/a/40250494/6062
    */
    public func range(from range: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
}

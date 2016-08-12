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
    
    private var regexPattern: NSRegularExpression
    
    public init?(pattern: String) {
        do {
            self.regexPattern = try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            return nil
        }
    }
    
    /// Regex pattern used to match.
    /// - Returns: `String` format of pattern
    public func toString() -> String {
        return regexPattern.pattern
    }
    
    /**
     Finds regex matches in a string.
     - Parameter str: the `String` to find matches in
     - Returns: A `Match` based on the matching result
     */
    internal func matchWithPattern(str: String) -> Match {
        let results = regexPattern.matchesInString(str, options: .ReportCompletion, range: NSRange(location: 0, length: str.startIndex.distanceTo(str.endIndex)))
        var components = [(String, Range<String.Index>)]()
        results.lazy.forEach {
            let stringRange = str.startIndex.advancedBy($0.range.location)..<str.startIndex.advancedBy($0.range.location + $0.range.length)
            components.append(str.substringWithRange(stringRange), stringRange)
        }
        return Match(components: components)
    }
    
    /**
     Replaces regex matches in string.
     - Parameter str: the `String` to find matches in
     - Parameter replacement: `String` to replace in the matches
     - Returns: A new `String` with the matches replaced
     */
    internal func replaceMatchesInString(str: String, replacement: String) -> String {
        let replaceString = NSMutableString(string: str)
        regexPattern.replaceMatchesInString(replaceString, options: .ReportCompletion, range: NSRange(location: 0, length: str.startIndex.distanceTo(str.endIndex)), withTemplate: replacement)
        return replaceString as String
    }
    
    /**
     Searches the string to find any match.
     - Parameter str: the `String` to find a match in
     - Returns: An optional `Int` of the location of the match
     */
    internal func search(str: String) -> Int? {
        if let result = regexPattern.firstMatchInString(str, options: .ReportCompletion, range: NSRange(location: 0, length: str.startIndex.distanceTo(str.endIndex))) {
            return result.range.location
        }
        return nil
    }
    
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
}

prefix operator <> { }

public prefix func <> (pattern: String) -> Regex? {
    return Regex(pattern: pattern)
}

infix operator =~ {}

public func =~ (input: String, regex: Regex) -> Bool {
    return regex.search(input) != nil
}

public func =~ (input: String, regexPatternStr: String) -> Bool {
    if let regex = Regex(pattern: regexPatternStr) {
        return regex.search(input) != nil
    }
    return false
}

extension String {
    /**
     Finds regex matches in the string. This method will find multiple matches in the string.
     - Parameter regex: `Regex` object that holds the pattern to find matches with
     - Returns: A `Match` based on the matching result
     */
    public func match(regex: Regex) -> Regex.Match {
        return regex.matchWithPattern(self)
    }
    
    /**
     Finds regex matches in the string and replaces those matches with the replacement string.
     - Parameter regex: `Regex` object that holds the pattern to find matches with
     - Parameter withString: The replacement `String` to insert in place of the match
     - Returns: A new `String` with the replacements applied
     */
    public func replace(regex: Regex, withString: String) -> String {
        return regex.replaceMatchesInString(self, replacement: withString)
    }
    
    /**
     Searches the string to find any match.
     - Parameter regex: `Regex` object that holds the pattern to find matches with
     - Returns: An optional `Int` of the location of the match
     */
    public func search(regex: Regex) -> Int? {
        return regex.search(self)
    }
}

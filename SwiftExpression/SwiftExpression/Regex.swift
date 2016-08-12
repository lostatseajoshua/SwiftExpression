//
//  Regex.swift
//  SwiftExpression
//
//  Created by Joshua Alvarado on 7/31/16.
//  Copyright © 2016 Joshua Alvarado. All rights reserved.
//

import Foundation

public struct Regex {
    
    private var regexPattern: NSRegularExpression
    
    public init?(pattern: String) {
        do {
            self.regexPattern = try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            return nil
        }
    }
    
    public func toString() -> String {
        return regexPattern.pattern
    }
    
    internal func matchWithPattern(str: String) -> Match {
        let results = regexPattern.matchesInString(str, options: .ReportCompletion, range: NSRange(location: 0, length: str.startIndex.distanceTo(str.endIndex)))
        var components = [(String, Range<String.Index>)]()
        results.lazy.forEach {
            let stringRange = str.startIndex.advancedBy($0.range.location)..<str.startIndex.advancedBy($0.range.location + $0.range.length)
            components.append(str.substringWithRange(stringRange), stringRange)
        }
        return Match(components: components)
    }
    
    internal func replaceMatchesInString(str: String, replacement: String) -> String {
        let replaceString = NSMutableString(string: str)
        regexPattern.replaceMatchesInString(replaceString, options: .ReportCompletion, range: NSRange(location: 0, length: str.startIndex.distanceTo(str.endIndex)), withTemplate: replacement)
        return replaceString as String
    }
    
    internal func search(str: String) -> Int? {
        if let result = regexPattern.firstMatchInString(str, options: .ReportCompletion, range: NSRange(location: 0, length: str.startIndex.distanceTo(str.endIndex))) {
            result.range.location
        }
        return nil
    }
    
    public struct Match {
        public let components: [(String, Range<String.Index>)]
        
        public func subStrings() -> [String] {
            return components.map {
                $0.0
            }
        }
        
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

infix operator ==~ {}

public func ==~ (input: String, regex: Regex) -> Bool {
    if let match = regex.search(input) where match > 0 {
        return true
    }
    return false
}

public func ==~ (input: String, regexPatternStr: String) -> Bool {
    if let regex = Regex(pattern: regexPatternStr) {
        if let match = regex.search(input) where match > 0 {
            return true
        }
    }
    return false
}

extension String {
    public func match(regex: Regex) -> Regex.Match {
        return regex.matchWithPattern(self)
    }
    
    public func replace(regex: Regex, withString: String) -> String {
        return regex.replaceMatchesInString(self, replacement: withString)
    }
    
    public func search(regex: Regex) -> Int? {
        return regex.search(self)
    }
}

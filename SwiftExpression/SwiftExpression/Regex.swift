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
    
    func toString() -> String {
        return regexPattern.pattern
    }
    
    internal func matchWithPattern(str: String) -> Match {
        let results = pattern.matchesInString(str, options: .ReportCompletion, range: NSRange(location: 0, length: str.startIndex.distanceTo(str.endIndex)))
        var components = [(String, Range<String.Index>)]()
        results.lazy.forEach {
            let stringRange = str.startIndex.advancedBy($0.range.location)..<str.startIndex.advancedBy($0.range.location + $0.range.length)
            components.append(str.substringWithRange(stringRange), stringRange)
        }
        return Match(components: components)
    }
    
    internal func replaceMatchesInString(inout str: String, replacement: String) -> Int {
        let replaceString = NSMutableString(string: str)
        let replaces = pattern.replaceMatchesInString(replaceString, options: .ReportCompletion, range: NSRange(location: 0, length: str.startIndex.distanceTo(str.endIndex)), withTemplate: replacement)
        str = replaceString as String
        return replaces
    }
    
    public struct Match {
        public var numberOfMatches: Int {
            return components.count
        }
        public var components: [(String, Range<String.Index>)]
    }
}

prefix operator <> { }

prefix func <> (pattern: String) -> Regex? {
    return Regex(pattern: pattern)
}

extension String {
    public func match(regex: Regex) -> Regex.Match {
        return regex.matchWithPattern(self)
    }
    
    public mutating func replaceMatches(regex: Regex, withString: String) {
        regex.replaceMatchesInString(&self, replacement: withString)
    }
    
    public func contains(regex: Regex) -> Bool {
        return true
    }
}

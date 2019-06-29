//
//  String+Extension.swift
//  SwiftExpression
//
//  Created by Joshua Alvarado on 12/3/18.
//

import Foundation.NSRange

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
}

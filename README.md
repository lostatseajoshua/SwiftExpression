[![Build Status](https://travis-ci.org/lostatseajoshua/SwiftExpression.svg?branch=master)](https://travis-ci.org/lostatseajoshua/SwiftExpression)
# SwiftExpression
Swift Expression is a Regex framework built with Swift to make it easier to work with NSRegularExpression. The framework provides low overhead to work with pattern mathcing.

## Motivation
There is not a native Regex implemenation in Swift or Objective-C as there is in other languages such as javascript or ruby. This framework's goal is to make it easier to work with Regex in a "Swifty" way. The framework is built on NSRegularExpression with just easy to call methods and easy objects to work with. To feel as native as possible the Swift `String` type has been extended with new methods for Regex.

## Code Example

##### Create a Regex object
A Regex can be created multiple ways.

###### Failable Initializer
``` swift
if let regex = Regex("^\\d") {
  // use regex object
}
```
###### Prefix operator
The prefix operator is used as a way to initialize a regex struct and is built on the failable initalizer.
```swift
let regex = <>"^\\d" {
  // use regex object
}
```

##### Infix operator
Use the custom infix to check for a match.
```swift
let str = "333-aa-bb"
let regexPatternStr = "^\\d"

// string to search in on left hand side, regex pattern in string format on right hand side
if str ~= regexPatternStr {
  // a match is in the string continue processing
} else {
  // failed to find a single match in string
}
```

##### String extension methods
Get matches in string.
```swift
let match = str.match(regex) // Returns a Regex.Match struct
match.components // Returns a collection of tuples that are the substring match and range of the match [(String, Range<String.Index>)]
match.subStrings() // Returns a collection of the substring matches [String]
match.ranges() // Returns a collection of ranges of the matches [Range<String.Index>]
```

Replace
```swift
str.replace(regex, replaceStr) // Returns a new string with matches replaced with replacement string
```

Search
```
str.search(regex) // Returns an optional Int of the location of the range of the first match found in the string
```

## Installation
```@available(iOS 8, *)```

#### CocoaPods 
You can use [Cocoapods](http://cocoapods.org/) to install `SwiftExpression` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
  pod 'SwiftExpression'
end
```

#### Manually

To use this library in your project manually do the following.

Projects: just drag Regex.swift into the project (check copy items if needed)

Workspaces: include the whole SwiftExpression.xcodeproj

## Contributors
Joshua Alvarado - [Twitter](https://www.twitter.com/alvaradojoshua0) - [Website](http://www.strictlyswift.com)

## License
This project is released under the [MIT license](https://github.com/realm/jazzy/blob/master/LICENSE).

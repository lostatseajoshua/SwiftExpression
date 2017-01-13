[![Build Status](https://travis-ci.org/lostatseajoshua/SwiftExpression.svg?branch=master)](https://travis-ci.org/lostatseajoshua/SwiftExpression) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/lostatseajoshua/SwiftExpression)
# SwiftExpression
Swift Expression is a Regex framework built with Swift to make it easier to work with NSRegularExpression. The framework provides low overhead to work with pattern mathcing.

## Motivation
There is not a native Regex implemenation in Swift or Objective-C as there is in other languages such as javascript or ruby. This framework's goal is to make it easier to work with Regex in a "Swifty" way. The framework is built on NSRegularExpression with just easy to call methods and easy objects to work with. To feel as native as possible the Swift `String` type has been extended with new methods for Regex.

## Requirements
Xcode 8

Swift 3

iOS 8.0+

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
if let regex = <>"^\\d" {
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
str.replace(regex, with: replaceStr) // Returns a new string with matches replaced with replacement string
```

Search
```swift
str.search(regex) // Returns an optional Int of the location of the range of the first match found in the string
```

Find
```swift
str.find(regex) // Returns true if a match exists in the string
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

#### Carthage

You can use [Carthage](https://github.com/Carthage/Carthage) to install `SwiftExpression` by adding it to your `Cartfile`:

```swift
github "lostatseajoshua/SwiftExpression"
```

#### Swift Package Manager

```swift
import PackageDescription

let package = Package(
    name: "YourProject",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/lostatseajoshua/SwiftExpression.git",
                 majorVersion: 2),
    ]
)
```

#### Manually

To use this library in your project manually do the following.

Add the SwiftExpression.framework to your project by downloading the framework from the [releases](https://github.com/lostatseajoshua/SwiftExpression/releases)

## Demo

Checkout this demo project that was built with SwiftExpression. It highlights text in a UITextView using regex pattern that is inputted into a UITextField!

[Demo Github project](https://github.com/lostatseajoshua/SwiftTextHighlight)

## Contributors
Joshua Alvarado - [Twitter](https://www.twitter.com/alvaradojoshua0) - [Website](http://www.strictlyswift.com)

## License
This project is released under the [MIT license](https://github.com/lostatseajoshua/SwiftExpression/blob/master/LICENSE).

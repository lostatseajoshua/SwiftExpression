// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftExpression",
    products: [
        .library(
            name: "SwiftExpression",
            targets: ["SwiftExpression"]),
        ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftExpression",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "SwiftExpressionTests",
            dependencies: ["SwiftExpression"],
            path: "Tests"),
        ],
    swiftLanguageVersions: [.v4_2]
)

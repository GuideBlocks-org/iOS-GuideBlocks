// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iOS-GuideBlocks",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "iOS-GuideBlocks",
            targets: ["iOS-GuideBlocks"]),
    ],
    dependencies: [
        .package(
            name: "ConfettiSwiftUI",
            url: "https://github.com/simibac/ConfettiSwiftUI", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "iOS-GuideBlocks",
            dependencies: [
              .product(name: "ContextualSDK", package: "Contextual"),
              .product(name: "ConfettiSwiftUI", package: "ConfettiSwiftUI")
            ]
        ),
    ]
)


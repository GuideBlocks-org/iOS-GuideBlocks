// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GuideBlocks",
    platforms: [
        .iOS(.v15),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "GuideBlocks",
            targets: ["GuideBlocks"]
        ),
    ],
    dependencies: [
        .package(
            name: "Contextual",
            url: "https://github.com/contextu-al/Contextual-SDK",
            .upToNextMajor(from: "3.0.3")
        ),
        .package(
            name: "ConfettiSwiftUI",
            url: "https://github.com/simibac/ConfettiSwiftUI",
            .upToNextMajor(from: "1.0.0")
        ),
    ],
    targets: [
        .target(
            name: "GuideBlocks",
            dependencies: [
                .product(name: "ContextualSDK", package: "Contextual"),
                .product(name: "ConfettiSwiftUI", package: "ConfettiSwiftUI")
            ]
        ),
        .testTarget(
            name: "GuideBlocksTests",
            dependencies: ["GuideBlocks"]
        ),
    ]
)


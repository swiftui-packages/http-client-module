// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HTTPClientModule",
    products: [
        .library(
            name: "HTTPClientModule",
            targets: ["HTTPClientModule"]
        )
    ],
    targets: [
        .target(name: "HTTPClientModule"),
        .testTarget(
            name: "HTTPClientModuleTests",
            dependencies: ["HTTPClientModule"]
        )
    ]
)

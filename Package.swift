// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "CodableMapper",
    products: [
        .library(
            name: "CodableMapper",
            targets: ["CodableMapper"])
    ],
    targets: [
        .target(
            name: "CodableMapper",
            dependencies: []),
        .testTarget(
            name: "CodableMapperTests",
            dependencies: ["CodableMapper"])
    ]
)

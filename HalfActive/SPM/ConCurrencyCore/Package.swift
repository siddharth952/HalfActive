// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ConCurrencyCore",
    platforms: [
        .iOS(.v15),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v7),
    ],
    products: [
        .library(
            name: "ConCurrencyCore",
            targets: ["ConCurrencyCore"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/groue/GRDB.swift", from: "7.3.0")
    ],
    targets: [
        .target(
            name: "ConCurrencyCore",
            dependencies: [
                .product(name: "GRDB", package: "GRDB.swift")
            ],
            path: "Sources"
        ),
    ],
    swiftLanguageVersions: [.v5]
)

// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "swiftui-navigation-util",
    platforms: [
        .iOS(.v15),
        .macOS(.v15)
    ],
    products: [
        .library(
            name: "NavigationUtil",
            targets: [
                "NavigationUtil"
            ]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/AsioOtus/swiftui-signal-util",
            from: "1.0.0"
        )
    ],
    targets: [
        .target(
            name: "NavigationUtil",
            dependencies: [
                .product(name: "SignalUtil", package: "swiftui-signal-util")
            ]
        ),
        .testTarget(
            name: "NavigationUtilTests",
            dependencies: [
                "NavigationUtil"
            ]
        )
    ]
)

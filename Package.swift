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
    targets: [
        .target(
            name: "NavigationUtil"
        ),
    ]
)

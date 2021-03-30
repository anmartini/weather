// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "weather",
    platforms: [
      .macOS(.v11),
      .iOS(.v14),
    ],
    products: [
        .library(name: "AppFeature", targets: ["AppFeature"]),
        .library(name: "Networking", targets: ["Networking"]),
        .library(name: "SharedModels", targets: ["SharedModels"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            .upToNextMajor(from: "0.17.0")
        ),
        .package(
            url: "https://github.com/Alamofire/Alamofire.git",
            .upToNextMajor(from: "5.4.1")
        )
    ],
    targets: [
        .target(
            name: "AppFeature",
            dependencies: [
                "SharedModels",
                "Networking",
                .product(name: "ComposableArchitecture",
                         package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "SharedModels",
            dependencies: []
        ),
        .target(
            name: "Networking",
            dependencies: [
                "Alamofire",
                "SharedModels"
            ]
        ),
    ]
)

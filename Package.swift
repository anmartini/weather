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
        .library(name: "RegionalWeatherFeature",
                 targets: ["RegionalWeatherFeature"]),
        .library(name: "CountriesFeature", targets: ["CountriesFeature"]),
        .library(name: "ApiClient", targets: ["ApiClient"]),
        .library(name: "ApiClientLive", targets: ["ApiClientLive"]),
        .library(name: "SharedModels", targets: ["SharedModels"]),
        .library(name: "Router", targets: ["Router"]),
        .library(name: "Routes", targets: ["Routes"]),
        .library(name: "SharedUtils", targets: ["SharedUtils"]),
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
                "ApiClient",
//                "SharedUtils",
                "SharedModels",
                .product(name: "ComposableArchitecture",
                         package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "RegionalWeatherFeature",
            dependencies: [
                "ApiClient",
                "SharedUtils",
                "SharedModels",
                .product(name: "ComposableArchitecture",
                         package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "CountriesFeature",
            dependencies: [
                "ApiClient",
                "SharedUtils",
                "SharedModels",
                .product(name: "ComposableArchitecture",
                         package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "ApiClient",
            dependencies: [
                "Routes",
                "Alamofire",
                "SharedModels",
                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture"
                ),
            ]
        ),
        .target(
            name: "ApiClientLive",
            dependencies: [
                "Router",
                "Routes",
                "ApiClient",
                "SharedModels",
                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture"
                ),
            ]
        ),
        .target(
            name: "SharedModels",
            dependencies: []
        ),
        .target(
            name: "Routes",
            dependencies: [
                "SharedModels"
            ]
        ),
        .target(
            name: "Router",
            dependencies: [
                "Routes",
                "Alamofire",
                "SharedModels"
            ]
        ),
        .target(
            name: "SharedUtils",
            dependencies: []
        ),
//        .testTarget(
//            name: "AppFeatureTests",
//            dependencies: [
//                "AppFeature",
//                "TestHelpers",
//                .product(name: "SnapshotTesting", package: "SnapshotTesting"),
//            ]
//        ),
        .testTarget(
            name: "RegionalWeatherFeatureTests",
            dependencies: [
                "RegionalWeatherFeature",
//                "TestHelpers",
//                .product(name: "SnapshotTesting", package: "SnapshotTesting"),
            ]
        ),
    ]
)

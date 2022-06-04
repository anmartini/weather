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
        .library(name: "RegionalWeatherFeature", targets: ["RegionalWeatherFeature"]),
        .library(name: "CountriesFeature", targets: ["CountriesFeature"]),
        .library(name: "CountryFeature", targets: ["CountryFeature"]),
        .library(name: "ApiClient", targets: ["ApiClient"]),
        .library(name: "ApiClientLive", targets: ["ApiClientLive"]),
        .library(name: "Router", targets: ["Router"]),
        .library(name: "Routes", targets: ["Routes"]),
        .library(name: "Resources", targets: ["Resources"]),
        .library(name: "SharedExtensions", targets: ["SharedExtensions"]),
        .library(name: "SharedModels", targets: ["SharedModels"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            .upToNextMajor(from: "0.36.0")
        ),
        .package(url: "http://github.com/pointfreeco/swift-url-routing", from: "0.2.0"),
        .package(url: "https://github.com/pointfreeco/swift-parsing", from: "0.9.2"),
        .package(
            url: "https://github.com/pointfreeco/xctest-dynamic-overlay",
            from: "0.2.1"
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
                "SharedModels",
                "CountriesFeature",
                "RegionalWeatherFeature",
                .product(name: "ComposableArchitecture",
                         package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "RegionalWeatherFeature",
            dependencies: [
                "ApiClient",
                "SharedExtensions",
                "SharedModels",
                .product(name: "ComposableArchitecture",
                         package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "CountriesFeature",
            dependencies: [
                "ApiClient",
                "SharedExtensions",
                "SharedModels",
                "CountryFeature",
                .product(name: "ComposableArchitecture",
                         package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "CountryFeature",
            dependencies: [
                "ApiClient",
                "SharedExtensions",
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
            name: "Resources",
            dependencies: []
        ),
        .target(
            name: "SharedExtensions",
            dependencies: []
        ),
        .target(
            name: "SharedModels",
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

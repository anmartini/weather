// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "weather",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
        .watchOS(.v7),
        .tvOS(.v15),
        .macOS(.v11),
    ],
    products: [
        .library(name: "AppFeature", targets: ["AppFeature"]),
        .library(name: "RegionalWeatherFeature", targets: ["RegionalWeatherFeature"]),
        .library(name: "CountriesFeature", targets: ["CountriesFeature"]),
        .library(name: "CountryFeature", targets: ["CountryFeature"]),
        .library(name: "ApiClient", targets: ["ApiClient"]),
        .library(name: "ApiClientLive", targets: ["ApiClientLive"]),
        .library(name: "ServerRouter", targets: ["ServerRouter"]),
        .library(name: "Resources", targets: ["Resources"]),
        .library(name: "SharedExtensions", targets: ["SharedExtensions"]),
        .library(name: "SharedModels", targets: ["SharedModels"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            branch: "concurrency-updates"
//            .upToNextMajor(from: "0.36.0")
        ),
        .package(url: "http://github.com/pointfreeco/swift-url-routing", from: "0.2.0"),
        .package(url: "https://github.com/pointfreeco/swift-parsing", from: "0.9.2"),
        .package(
            url: "https://github.com/pointfreeco/xctest-dynamic-overlay",
            from: "0.2.1"
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
                "SharedModels",
            ]
        ),
        .target(
            name: "ApiClientLive",
            dependencies: [
                "ApiClient",
                "ServerRouter",
                "SharedModels",
//                .product(
//                    name: "ComposableArchitecture",
//                    package: "swift-composable-architecture"
//                ),
            ]
        ),
        .target(
            name: "ServerRouter",
            dependencies: [
                "SharedModels",
                .product(name: "Parsing", package: "swift-parsing"),
                .product(name: "URLRouting", package: "swift-url-routing"),
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
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

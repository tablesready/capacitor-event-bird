// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CapacitorEventBird",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "CapacitorEventBird",
            targets: ["CapacitorEventBirdPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "CapacitorEventBirdPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/CapacitorEventBirdPlugin"),
        .testTarget(
            name: "CapacitorEventBirdPluginTests",
            dependencies: ["CapacitorEventBirdPlugin"],
            path: "ios/Tests/CapacitorEventBirdPluginTests")
    ]
)
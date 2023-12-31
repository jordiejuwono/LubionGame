// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Favorite",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Favorite",
            targets: ["Favorite"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/realm/realm-swift.git", branch: "master"),
        .package(path: "../Common"),
        .package(url: "https://github.com/jordiejuwono/LubionGame-Core-Package.git", branch: "main")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Favorite",
            dependencies: [
                .product(name: "RealmSwift", package: "realm-swift"),
                "Common",
                .product(name: "CorePackage", package: "LubionGame-Core-Package"),
            ]),
        .testTarget(
            name: "FavoriteTests",
            dependencies: ["Favorite"]),
    ]
)

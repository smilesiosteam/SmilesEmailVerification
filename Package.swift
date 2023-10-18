// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SmilesEmailVerification",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SmilesEmailVerification",
            targets: ["SmilesEmailVerification"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/smilesiosteam/SmilesUtilities.git", branch: "main"),
        .package(url: "https://github.com/smilesiosteam/SmilesLanguageManager.git", branch: "main"),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .upToNextMajor(from: "1.8.0")),
        .package(url: "https://github.com/smilesiosteam/SmilesBaseMainRequest.git", branch: "main"),
        .package(url: "https://github.com/Juanpe/SkeletonView.git", from: "1.7.0"),
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.1.0"),
        .package(url: "https://github.com/smilesiosteam/SmilesFontsManager.git", branch: "main"),
        .package(url: "https://github.com/smilesiosteam/NetworkingLayer.git", branch: "main")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SmilesEmailVerification",
            dependencies: [
                .product(name: "SmilesUtilities", package: "SmilesUtilities"),
                .product(name: "SmilesLanguageManager", package: "SmilesLanguageManager"),
                .product(name: "CryptoSwift", package: "CryptoSwift"),
                .product(name: "SmilesBaseMainRequestManager", package: "SmilesBaseMainRequest"),
                .product(name: "SkeletonView", package: "SkeletonView"),
                .product(name: "SDWebImage", package: "SDWebImage"),
                .product(name: "SmilesFontsManager", package: "SmilesFontsManager"),
                .product(name: "NetworkingLayer", package: "NetworkingLayer")
            ]),
        .testTarget(
            name: "SmilesEmailVerificationTests",
            dependencies: ["SmilesEmailVerification"]),
    ]
)

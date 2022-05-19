// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TDDKata",
    products: [
        .library(
            name: "TDDKata",
            targets: ["TDDKata"]),
        .library(
            name: "BowlingGame",
            targets: ["BowlingGame"]),
        .library(
                name: "ScoreKeeper",
                targets: ["ScoreKeeper"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "TDDKata",
            dependencies: []),
        .testTarget(
            name: "TDDKataTests",
            dependencies: ["TDDKata"]),
        .target(
            name: "BowlingGame",
            dependencies: []),
        .testTarget(
            name: "BowlingGameTests",
            dependencies: ["BowlingGame"]),
        .target(
                name: "ScoreKeeper",
                dependencies: []),
        .testTarget(
                name: "ScoreKeeperTests",
                dependencies: ["ScoreKeeper"]),
    ]
)

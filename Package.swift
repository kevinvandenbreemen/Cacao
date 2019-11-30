// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Cacao",
    products: [
        .library(name: "Cacao", targets: ["Cacao"]),
        .executable(name: "CacaoDemo", targets: ["CacaoDemo"]),
        ],
    dependencies: [
        .package(
            url: "https://github.com/PureSwift/Silica.git",
            .branch("master")
        ),
        .package(
            url: "https://github.com/kevinvandenbreemen/Cairo.git",
            .branch("master")
        ),
        .package(
            url: "https://github.com/kevinvandenbreemen/SDL-1.git",
            .branch("forPullRequests")
        ),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.2.0"),
    ],
    targets: [
        .target(
            name: "Cacao",
            dependencies: [
                "Silica",
                "Cairo",
                "SDL",
                "Logging"
            ]
        ),
        .target(
            name: "CacaoDemo",
            dependencies: [
                "Cacao"
            ]
        ),
        .testTarget(name: "CacaoTests", dependencies: ["Cacao"])
        ]
)

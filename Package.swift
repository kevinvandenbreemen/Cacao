// swift-tools-version:4.1
import PackageDescription

let package = Package(
    name: "Cacao",
    products: [
        .library(name: "Cacao", targets: ["Cacao"]),
        .executable(name: "CacaoDemo", targets: ["CacaoDemo"]),
        ],
    dependencies: [
        .package(
            url: "https://github.com/kevinvandenbreemen/Silica.git",
            .branch("master")
        ),
        .package(
            url: "https://github.com/kevinvandenbreemen/Cairo.git",
            .branch("master")
        ),
        .package(
            url: "https://github.com/PureSwift/SDL.git",
            .branch("master")
        )
    ],
    targets: [
        .target(
            name: "Cacao",
            dependencies: [
                "Silica",
                "Cairo",
                "SDL"
            ]
        ),
        .target(
            name: "CacaoDemo",
            dependencies: [
                "Cacao"
            ]
        ),
        ]
)

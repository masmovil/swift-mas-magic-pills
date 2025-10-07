// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "MagicPills",
    platforms: [
        .iOS("16"),
        .macCatalyst("16"),
        .tvOS("16"),
        .watchOS("9"),
        .macOS("13"),
    ],
    products: [
        .library(
            name: "MasMagicPills",
            targets: ["MasMagicPills"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MasMagicPills",
            dependencies: [],
            path: "Sources",
            swiftSettings: [
                .enableUpcomingFeature("BareSlashRegexLiterals")
            ]
        ),
        .testTarget(
            name: "MagicPillsTests",
            dependencies: ["MasMagicPills"],
            path: "Tests",
            resources: [
                .copy("Helpers/LocalizedSample.strings")
            ],
            swiftSettings: [
                .enableUpcomingFeature("BareSlashRegexLiterals")
            ]
        ),
    ]
)

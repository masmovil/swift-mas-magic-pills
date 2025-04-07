// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "MagicPills",
    platforms: [
        .iOS("16"),
        .macOS(.v11),
        .tvOS(.v13),
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
            exclude: [
                "../_config.yml",
                "../Mintfile",
                "../Rakefile",
            ]
        ),
        .testTarget(
            name: "MagicPillsTests",
            dependencies: ["MasMagicPills"],
            path: "Tests"
        ),
    ]
)

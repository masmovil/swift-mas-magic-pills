// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "MagicPills",
    platforms: [
        .iOS("16"),
        .macCatalyst("16"),
        .tvOS("16"),
        .watchOS("7.0"),
        .macOS("12"),
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
            path: "Sources"
        ),
        .testTarget(
            name: "MagicPillsTests",
            dependencies: ["MasMagicPills"],
            path: "Tests",
            resources: [
                .copy("Helpers/LocalizedSample.strings"),
                .process("UIKit/Extensions/Views/iOS/CollectionCellForTests.xib"),
                .process("UIKit/Extensions/Views/iOS/TableViewCellForTests.xib")
            ]
        ),
    ]
)

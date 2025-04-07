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
            path: "Sources"
        ),
        .testTarget(
            name: "MagicPillsTests",
            dependencies: ["MasMagicPills"],
            path: "Tests",
            resources: [
                .copy("Helpers/LocalizedSample.strings"),
                .copy("UIKit/Extensions/Views/iOS/CollectionCellForTests.xib"),
                .copy("UIKit/Extensions/Views/iOS/TableViewCellForTests.xib")
            ]
        ),
    ]
)

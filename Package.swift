// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "AppleNewsServerLibrary",
    platforms: [
        .iOS(.v14),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "AppleNewsServerLibrary",
            targets: ["AppleNewsServerLibrary"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio", from: "2.0.0"),
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.9.0")
    ],
    targets: [
        .target(
            name: "AppleNewsServerLibrary",
            dependencies: [
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
                .product(name: "NIOHTTP1", package: "swift-nio")
            ]),
        .testTarget(
            name: "AppleNewsServerLibraryTests",
            dependencies: [
                .target(name: "AppleNewsServerLibrary")
            ]
        )
    ]
)

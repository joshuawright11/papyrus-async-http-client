// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "papyrus-async-http-client",
    platforms: [
        .iOS("13.0"),
        .macOS("10.15"),
    ],
    products: [
        .executable(name: "Example", targets: ["Example"]),
        .library(
            name: "PapyrusAsyncHTTPClient",
            targets: ["PapyrusAsyncHTTPClient"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.9.0"),
        .package(url: "https://github.com/joshuawright11/papyrus.git", branch: "main"),
    ],
    targets: [
        .executableTarget(
            name: "Example",
            dependencies: [
                .byName(name: "PapyrusAsyncHTTPClient")
            ],
            path: "Example"),
        .target(
            name: "PapyrusAsyncHTTPClient",
            dependencies: [
                .product(name: "PapyrusCore", package: "papyrus"),
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
            ],
            path: "PapyrusAsyncHTTPClient"
        ),
        .testTarget(
            name: "PapyrusAsyncHTTPClientTests",
            dependencies: ["PapyrusAsyncHTTPClient"]),
    ]
)

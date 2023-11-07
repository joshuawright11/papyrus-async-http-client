// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "papyrus-async-http-client",
    platforms: [
        .iOS("13.0"),
        .macOS("10.15"),
    ],
    products: [
        .library(
            name: "PapyrusAsyncHTTPClient",
            targets: [
                "PapyrusAsyncHTTPClient"
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.9.0"),
        .package(url: "https://github.com/joshuawright11/papyrus.git", from: "0.6.0"),
    ],
    targets: [
        .target(
            name: "PapyrusAsyncHTTPClient",
            dependencies: [
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
                .product(name: "PapyrusCore", package: "papyrus"),
            ],
            path: "PapyrusAsyncHTTPClient"
        ),
    ]
)

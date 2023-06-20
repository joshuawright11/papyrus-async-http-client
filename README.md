# PapyrusAsyncHTTPClient 📜

<a href="https://swift.org"><img src="https://img.shields.io/badge/Swift-5.9-orange.svg" alt="Swift Version"></a>
<a href="https://github.com/joshuawright11/papyrus-async-http-client/releases"><img src="https://img.shields.io/github/release/joshuawright11/papyrus-async-http-client.svg" alt="Latest Release"></a>
<a href="https://github.com/joshuawright11/papyrus-async-http-client/blob/main/LICENSE"><img src="https://img.shields.io/github/license/joshuawright11/papyrus-async-http-client.svg" alt="License"></a>

This is an [async-http-client](https://github.com/swift-server/async-http-client) based driver for [Papyrus](https://github.com/joshuawright11/papyrus).

You can see the Papyrus documentation in the [main repository](https://github.com/joshuawright11/papyrus).

## Installation

You can install PapyrusAsyncHTTPClient using the [Swift Package Manager](https://www.swift.org/package-manager/).

```swift
dependencies: [
    .package(url: "https://github.com/joshuawright11/papyrus-async-http-client.git", .upToNextMinor(from: "0.1.0"))
]
```

## Usage

You can use this Papyrus driver by importing it instead.

```swift
import PapyrusAsyncHTTPClient
```

### Configuration

Under the hood, PapyrusAsyncHTTPClient uses [async-http-client](https://github.com/swift-server/async-http-client) to make requests. If you'd like to use a custom `HTTPClient` for making requests, pass it in when initializing a `Provider`.

```swift
let customClient: HTTPClient = ...
let provider = Provider(baseURL: "https://api.github.com", client: customClient)
let github: GitHub = GitHubAPI(provider: provider)
```

If needbe, you can also access the under-the-hood `HTTPClient` types on a `Response`.

```swift
let response: Response = ...
let httpClientRequest: HTTPClient.Request = response.request
let httpClientResponse: HTTPClient.Response = response.response!
```

## Contribution

👋 Thanks for checking out Papyrus!

If you'd like to contribute please [file an issue](https://github.com/joshuawright11/papyrus/issues), [open a pull request](https://github.com/joshuawright11/papyrus/issues) or [start a discussion](https://github.com/joshuawright11/papyrus/discussions).

## License

Papyrus is released under an MIT license. See [License.md](License.md) for more information.

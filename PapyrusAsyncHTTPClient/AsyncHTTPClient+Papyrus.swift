import AsyncHTTPClient
import Foundation
import NIOHTTP1
@_exported import PapyrusCore

extension Provider {
    public convenience init(baseURL: String,
                            httpClient: HTTPClient = HTTPClient(eventLoopGroupProvider: .createNew),
                            modifiers: [RequestModifier] = [],
                            interceptors: [Interceptor] = []) {
        self.init(baseURL: baseURL, http: httpClient, modifiers: modifiers, interceptors: interceptors)
    }
}

// MARK: `HTTPService` Conformance

extension HTTPClient: HTTPService {
    public func build(method: String, url: URL, headers: [String: String], body: Data?) -> PapyrusCore.Request {
        _Request(method: method, url: url, headers: headers, body: body)
    }

    public func request(_ req: PapyrusCore.Request) async -> PapyrusCore.Response {
        let req = req.request
        do {
            let res = try await execute(request: req).get()
            return _Response(request: req, response: res, error: nil)
        } catch {
            return _Response(request: req, response: nil, error: error)
        }
    }

    public func request(_ req: PapyrusCore.Request, completionHandler: @escaping (PapyrusCore.Response) -> Void) {
        let req = req.request
        execute(request: req).whenComplete { result in
            switch result {
            case .success(let res):
                completionHandler(_Response(request: req, response: res, error: nil))
            case .failure(let error):
                completionHandler(_Response(request: req, response: nil, error: error))
            }
        }
    }
}

// MARK: `Response` Conformance

extension Response {
    public var request: HTTPClient.Request {
        (self as! _Response).request
    }

    public var response: HTTPClient.Response? {
        (self as! _Response).response
    }
}

private struct _Response: Response {
    let request: HTTPClient.Request
    let response: HTTPClient.Response?
    let error: Error?
    var body: Data? { response?.body.map { Data(buffer: $0) } }
    var headers: [String: String]? { response?.headers.dict }
    var statusCode: Int? { response.map { Int($0.status.code) } }
}

// MARK: `Request` Conformance

extension Request {
    public var request: HTTPClient.Request {
        (self as! _Request).request
    }
}

private struct _Request: Request {
    var request: HTTPClient.Request {
        let method = HTTPMethod(rawValue: method)
        let body = body.map { HTTPClient.Body.data($0) }
        var headers = HTTPHeaders()
        for (key, value) in headers {
            headers.add(name: key, value: value)
        }

        return try! HTTPClient.Request(url: url.absoluteString,
                                       method: method,
                                       headers: headers,
                                       body: body)
    }

    var method: String
    var url: URL
    var headers: [String : String]
    var body: Data?
}

// MARK: Utilities

extension HTTPHeaders {
    fileprivate var dict: [String: String] {
        Dictionary(Array(self), uniquingKeysWith: { _, last in last })
    }
}

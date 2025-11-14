//
//  AppleNewsAPIClient.swift
//  articles-library-swift
//
//  Created by Axel Martinez on 13/11/25.
//

import Foundation
import CommonCrypto
import AsyncHTTPClient
import NIOHTTP1

public actor AppleNewsServerAPIClient: Sendable {

    public enum ConfigurationError: Swift.Error, Hashable, Sendable {
        /// Invalid configuration for Apple News API Client
        case invalidConfiguration
    }
    
    private static let userAgent = "apple-news-library/swift/1.0.0"
    private static let productionUrl = "https://news-api.apple.com"
    
    private let apiKey: String
    private let apiSecret: String
    private let url: String
    private let client: HTTPClient
    // For testing purposes
    private var executeRequestOverride: (@Sendable (HTTPClientRequest, Data?) async throws -> HTTPClientResponse)?

    ///Create an Apple News API client
    ///
    ///- Parameter apiKey: Your API key from Apple News Publisher
    ///- Parameter apiSecret: Your API secret from Apple News Publisher
    public init(apiKey: String, apiSecret: String) throws {
        guard !apiKey.isEmpty, !apiSecret.isEmpty else {
            throw ConfigurationError.invalidConfiguration
        }
        self.apiKey = apiKey
        self.apiSecret = apiSecret
        self.url = AppleNewsServerAPIClient.productionUrl
        self.executeRequestOverride = nil
        self.client = .init()
    }
    
    deinit {
        try? self.client.syncShutdown()
    }

    // Test helper method to set request override
    internal func setExecuteRequestOverride(_ override: @escaping @Sendable (HTTPClientRequest, Data?) async throws -> HTTPClientResponse) {
        self.executeRequestOverride = override
    }
    
    private enum RequestBody {
        case encodable(any Encodable)
        case raw(Data, contentType: String)
    }

    private func makeRequest<T: Encodable>(path: String, method: HTTPMethod, queryParameters: [String: [String]], body: T?) async -> APIResult<Data> {
        if let b = body {
            return await makeRequest(path: path, method: method, queryParameters: queryParameters, body: .encodable(b))
        } else {
            return await makeRequest(path: path, method: method, queryParameters: queryParameters, body: nil)
        }
    }

    private func makeRequest(path: String, method: HTTPMethod, queryParameters: [String: [String]], body: Data, contentType: String) async -> APIResult<Data> {
        return await makeRequest(path: path, method: method, queryParameters: queryParameters, body: .raw(body, contentType: contentType))
    }

    private func makeRequest(path: String, method: HTTPMethod, queryParameters: [String: [String]], body: RequestBody?) async -> APIResult<Data> {
        do {
            var queryItems: [URLQueryItem] = []
            for (parameter, values) in queryParameters {
                for val in values {
                    queryItems.append(URLQueryItem(name: parameter, value: val))
                }
            }
            var urlComponents = URLComponents(string: self.url)
            urlComponents?.path = path
            if !queryItems.isEmpty {
                urlComponents?.queryItems = queryItems
            }
            
            guard let url = urlComponents?.url else {
                return APIResult.failure(statusCode: nil, rawApiError: nil, apiError: nil, errorMessage: nil, causedBy: nil)
            }
            
            var urlRequest = HTTPClientRequest(url: url.absoluteString)
            
            let requestBody: Data?
            if let b = body {
                let data: Data
                let contentType: String
                switch b {
                case .encodable(let encodable):
                    let jsonEncoder = getJsonEncoder()
                    data = try jsonEncoder.encode(encodable)
                    contentType = "application/json"
                case .raw(let rawData, let ct):
                    data = rawData
                    contentType = ct
                }
                requestBody = data
                urlRequest.body = .bytes(.init(data: data))
                urlRequest.headers.add(name: "Content-Type", value: contentType)
            } else {
                requestBody = nil
            }
            
            // Generate authorization header for Apple News API
            let authHeader = try generateAuthorizationHeader(
                method: method.rawValue,
                url: url.absoluteString,
                body: requestBody
            )
            
            urlRequest.headers.add(name: "User-Agent", value: AppleNewsServerAPIClient.userAgent)
            urlRequest.headers.add(name: "Authorization", value: authHeader)
            urlRequest.headers.add(name: "Accept", value: "application/json")
            urlRequest.method = method
            
            let response = try await executeRequest(urlRequest, requestBody)
            var body = try await response.body.collect(upTo: 1024 * 1024)
            guard let data = body.readData(length: body.readableBytes) else {
                throw APIFetchError()
            }
            if response.status.code >= 200 && response.status.code < 300 {
                return APIResult.success(response: data)
            } else if let decodedBody = try? getJsonDecoder().decode(ErrorPayload.self, from: data), let errorCode = decodedBody.errorCode, let errorMessage = decodedBody.errorMessage {
                return APIResult.failure(statusCode: Int(response.status.code), rawApiError: errorCode, apiError: APIError.init(rawValue: errorCode), errorMessage: errorMessage, causedBy: nil)
            } else {
                return APIResult.failure(statusCode: Int(response.status.code), rawApiError: nil, apiError: nil, errorMessage: nil, causedBy: nil)
            }
        } catch (let error) {
            return APIResult.failure(statusCode: nil, rawApiError: nil, apiError: nil, errorMessage: nil, causedBy: error)
        }
    }
    
    // requestBody passed for testing purposes
    internal func executeRequest(_ urlRequest: HTTPClientRequest, _ requestBody: Data?) async throws -> HTTPClientResponse {
        if let override = executeRequestOverride {
            return try await override(urlRequest, requestBody)
        }
        return try await self.client.execute(urlRequest, timeout: .seconds(30))
    }
    
    private func makeRequestWithResponseBody<T: Encodable, R: Decodable>(path: String, method: HTTPMethod, queryParameters: [String: [String]], body: T?) async -> APIResult<R> {
        let response = await makeRequest(path: path, method: method, queryParameters: queryParameters, body: body)
        switch response {
        case .success(let data):
            let decoder = getJsonDecoder()
            do {
                let decodedBody = try decoder.decode(R.self, from: data)
                return APIResult.success(response: decodedBody)
            } catch (let error) {
                return APIResult.failure(statusCode: nil, rawApiError: nil, apiError: nil, errorMessage: nil, causedBy: error)
            }
        case .failure(let statusCode, let rawApiError, let apiError, let errorMessage, let error):
            return APIResult.failure(statusCode: statusCode, rawApiError: rawApiError, apiError: apiError, errorMessage: errorMessage, causedBy: error)
        }
    }
    
    private func makeRequestWithoutResponseBody<T: Encodable>(path: String, method: HTTPMethod, queryParameters: [String: [String]], body: T?) async -> APIResult<Void> {
        let response = await makeRequest(path: path, method: method, queryParameters: queryParameters, body: body)
        switch response {
            case .success:
                return APIResult.success(response: ())
            case .failure(let statusCode, let rawApiError, let apiError, let errorMessage, let causedBy):
                return APIResult.failure(statusCode: statusCode, rawApiError: rawApiError, apiError: apiError, errorMessage: errorMessage, causedBy: causedBy)
        }
    }

    private func makeRequestWithoutResponseBody(path: String, method: HTTPMethod, queryParameters: [String: [String]], body: Data, contentType: String) async -> APIResult<Void> {
        let response = await makeRequest(path: path, method: method, queryParameters: queryParameters, body: body, contentType: contentType)
        switch response {
            case .success:
                return APIResult.success(response: ())
            case .failure(let statusCode, let rawApiError, let apiError, let errorMessage, let causedBy):
                return APIResult.failure(statusCode: statusCode, rawApiError: rawApiError, apiError: apiError, errorMessage: errorMessage, causedBy: causedBy)
        }
    }

    private func generateAuthorizationHeader(method: String, url: String, body: Data?) throws -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let dateString = dateFormatter.string(from: date)
        
        // Canonical request construction
        var canonicalRequest = "\(method)\(url)\(dateString)"
        
        // Add content type and body hash if body exists
        if let bodyData = body {
            let contentType = "application/json"
            canonicalRequest += contentType
            
            // Calculate body hash
            let bodyHash = sha256Hash(data: bodyData)
            canonicalRequest += bodyHash
        }
        
        // Create signature
        let signature = hmacSha256(key: apiSecret, message: canonicalRequest)
        
        // Return authorization header
        return "HHMAC; key=\(apiKey); signature=\(signature); date=\(dateString)"
    }
    
    private func sha256Hash(data: Data) -> String {
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
    
    private func hmacSha256(key: String, message: String) -> String {
        guard let keyData = key.data(using: .utf8),
              let messageData = message.data(using: .utf8) else {
            return ""
        }
        
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        keyData.withUnsafeBytes { keyBytes in
            messageData.withUnsafeBytes { messageBytes in
                CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256),
                       keyBytes.baseAddress, keyData.count,
                       messageBytes.baseAddress, messageData.count,
                       &hash)
            }
        }
        
        return Data(hash).base64EncodedString()
    }
    
    // MARK: - Apple News API Methods
    
    ///Read channel information
    ///
    ///- Parameter channelId: The channel identifier
    ///- Returns: Channel information or error
    ///[Read Channel Information](https://developer.apple.com/documentation/apple_news/read_channel_information)
    public func readChannel(channelId: String) async -> APIResult<ChannelResponse> {
        let request: String? = nil
        return await makeRequestWithResponseBody(path: "/channels/" + channelId, method: .GET, queryParameters: [:], body: request)
    }
    
    ///Create an article
    ///
    ///- Parameter channelId: The channel identifier
    ///- Parameter article: The article metadata and content
    ///- Returns: The created article information or error
    ///[Create an Article](https://developer.apple.com/documentation/apple_news/create_an_article)
    public func createArticle(channelId: String, article: Data) async -> APIResult<ArticleResponse> {
        return await makeRequestWithResponseBody(path: "/channels/" + channelId + "/articles", method: .POST, queryParameters: [:], body: article)
    }
    
    ///Read article information
    ///
    ///- Parameter articleId: The article identifier
    ///- Returns: Article information or error
    ///[Read Article Information](https://developer.apple.com/documentation/apple_news/read_article_information)
    public func readArticle(articleId: String) async -> APIResult<ArticleResponse> {
        let request: String? = nil
        return await makeRequestWithResponseBody(path: "/articles/" + articleId, method: .GET, queryParameters: [:], body: request)
    }
    
    ///Update an article
    ///
    ///- Parameter articleId: The article identifier
    ///- Parameter revision: The current revision token
    ///- Parameter article: The updated article data
    ///- Returns: The updated article information or error
    ///[Update an Article](https://developer.apple.com/documentation/apple_news/update_an_article)
    public func updateArticle(articleId: String, revision: String, article: Data) async -> APIResult<ArticleResponse> {
        var queryParams: [String: [String]] = [:]
        queryParams["revision"] = [revision]
        return await makeRequestWithResponseBody(path: "/articles/" + articleId, method: .POST, queryParameters: queryParams, body: article)
    }
    
    ///Delete an article
    ///
    ///- Parameter articleId: The article identifier
    ///- Returns: Success or error
    ///[Delete an Article](https://developer.apple.com/documentation/apple_news/delete_an_article)
    public func deleteArticle(articleId: String) async -> APIResult<Void> {
        let request: String? = nil
        return await makeRequestWithoutResponseBody(path: "/articles/" + articleId, method: .DELETE, queryParameters: [:], body: request)
    }
    
    ///Search for articles in a channel
    ///
    ///- Parameter channelId: The channel identifier
    ///- Parameter fromDate: Optional start date for the search
    ///- Parameter toDate: Optional end date for the search
    ///- Returns: List of articles or error
    ///[Search for Articles](https://developer.apple.com/documentation/apple_news/search_for_articles)
    public func searchArticles(channelId: String, fromDate: Date? = nil, toDate: Date? = nil) async -> APIResult<SearchResponse> {
        let request: String? = nil
        var queryParams: [String: [String]] = [:]
        
        if let from = fromDate {
            let dateFormatter = ISO8601DateFormatter()
            queryParams["fromDate"] = [dateFormatter.string(from: from)]
        }
        
        if let to = toDate {
            let dateFormatter = ISO8601DateFormatter()
            queryParams["toDate"] = [dateFormatter.string(from: to)]
        }
        
        return await makeRequestWithResponseBody(path: "/channels/" + channelId + "/articles", method: .GET, queryParameters: queryParams, body: request)
    }
    
    ///Read section information
    ///
    ///- Parameter sectionId: The section identifier
    ///- Returns: Section information or error
    ///[Read Section Information](https://developer.apple.com/documentation/apple_news/read_section_information)
    public func readSection(sectionId: String) async -> APIResult<SectionResponse> {
        let request: String? = nil
        return await makeRequestWithResponseBody(path: "/sections/" + sectionId, method: .GET, queryParameters: [:], body: request)
    }
    
    ///List sections in a channel
    ///
    ///- Parameter channelId: The channel identifier
    ///- Returns: List of sections or error
    ///[List Sections](https://developer.apple.com/documentation/apple_news/list_sections)
    public func listSections(channelId: String) async -> APIResult<SectionsResponse> {
        let request: String? = nil
        return await makeRequestWithResponseBody(path: "/channels/" + channelId + "/sections", method: .GET, queryParameters: [:], body: request)
    }
    
    ///Promote an article to a section
    ///
    ///- Parameter articleId: The article identifier
    ///- Parameter sectionId: The section identifier to promote to
    ///- Returns: Success or error
    ///[Promote an Article](https://developer.apple.com/documentation/apple_news/promote_an_article)
    public func promoteArticle(articleId: String, sectionId: String) async -> APIResult<Void> {
        struct PromoteRequest: Encodable {
            let sectionId: String
        }
        let body = PromoteRequest(sectionId: sectionId)
        return await makeRequestWithoutResponseBody(path: "/articles/" + articleId + "/promote", method: .POST, queryParameters: [:], body: body)
    }
    
    private struct APIFetchError: Swift.Error {}
}

public enum APIResult<T: Sendable>: Sendable {
    case success(response: T)
    case failure(statusCode: Int?, rawApiError: Int64?, apiError: APIError?, errorMessage: String?, causedBy: Swift.Error?)
}

public enum APIError: Int64, Hashable, Sendable {
    ///An error that indicates an invalid request.
    case generalBadRequest = 4000000

    ///An error that indicates authentication failed.
    case authenticationFailed = 4010000

    ///An error that indicates insufficient permissions.
    case forbidden = 4030000

    ///An error that indicates the resource was not found.
    case notFound = 4040000

    ///An error that indicates a conflict with the current state.
    case conflict = 4090000

    ///An error that indicates the request entity is too large.
    case requestEntityTooLarge = 4130000

    ///An error that indicates too many requests.
    case rateLimitExceeded = 4290000

    ///An error that indicates a general internal error.
    case generalInternal = 5000000

    ///An error response that indicates an unknown error occurred, but you can try again.
    case generalInternalRetryable = 5000001
}

internal struct ErrorPayload: Decodable {
    let errorCode: Int64?
    let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "code"
        case errorMessage = "message"
    }
}

internal func getJsonEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    return encoder
}

internal func getJsonDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
}

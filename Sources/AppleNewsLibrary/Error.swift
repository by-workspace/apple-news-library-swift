//
//  Error.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

/// An individual API error
public struct Error: Codable, Sendable {
    public let code: String
    public let keyPath: String?
    public let value: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case keyPath = "field"
        case value
    }
    
    public init(code: String, keyPath: String? = nil, value: String? = nil) {
        self.code = code
        self.keyPath = keyPath
        self.value = value
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(String.self, forKey: .code)
        self.keyPath = try container.decodeIfPresent(String.self, forKey: .keyPath)
        self.value = try container.decodeIfPresent(String.self, forKey: .value)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.code, forKey: .code)
        try container.encodeIfPresent(self.keyPath, forKey: .keyPath)
        try container.encodeIfPresent(self.value, forKey: .value)
    }
}

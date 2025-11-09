//
//  Error.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// An individual API error
public struct Error: Codable, Sendable {
    public let code: String
    public let status: Int
    public let keyPath: [String]?
    public let value: String?
    public let message: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case status
        case keyPath = "field"
        case value
        case message
    }
    
    public init(
        code: String,
        status: Int,
        keyPath: [String]? = nil,
        value: String? = nil,
        message: String? = nil
    ) {
        self.code = code
        self.keyPath = keyPath
        self.value = value
        self.status = status
        self.message = message  
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.code = try container.decode(String.self, forKey: .code)
        self.status = try container.decode(Int.self, forKey: .status)
        self.keyPath = try container.decodeIfPresent([String].self, forKey: .keyPath)
        self.value = try container.decodeIfPresent(String.self, forKey: .value)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.code, forKey: .code)
        try container.encode(self.status, forKey: .status)
        try container.encodeIfPresent(self.keyPath, forKey: .keyPath)
        try container.encodeIfPresent(self.value, forKey: .value)
        try container.encodeIfPresent(self.message, forKey: .message)
    }
}

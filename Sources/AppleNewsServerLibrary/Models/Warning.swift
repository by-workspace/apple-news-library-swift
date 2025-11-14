//
//  Warning.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

/// An individual API error
public struct Warning: Codable, Sendable {
    public let message: String
    public let keyPath: [String]?
    public let value: String?
    
    public init(message: String, keyPath: [String]? = nil, value: String? = nil) {
        self.message = message
        self.keyPath = keyPath
        self.value = value
    }
}

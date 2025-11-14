//
//  ErrorResponse.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// Error response from Apple News API
public struct ErrorResponse: Codable, Sendable, Swift.Error {
    public let errors: [Error]
    
    enum CodingKeys: String, CodingKey {
        case errors
    }
    
    public init(errors: [Error]) {
        self.errors = errors
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.errors = try container.decode([Error].self, forKey: .errors)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.errors, forKey: .errors)
    }
}

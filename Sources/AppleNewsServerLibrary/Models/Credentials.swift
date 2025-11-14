//
//  Credentials.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// Credentials for authenticating with Apple News API
public struct Credentials: Codable, Sendable {
    public let apiKeyId: String
    public let apiSecret: String
    
    public init(apiKeyId: String, apiSecret: String) {
        self.apiKeyId = apiKeyId
        self.apiSecret = apiSecret
    }
}

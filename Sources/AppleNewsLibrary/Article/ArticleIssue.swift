//
//  ArticleIssue.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// An individual issue with an article
public struct ArticleIssue: Codable, Sendable {
    public let code: String
    public  let componentIdentifier: String?
    public let message: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case componentIdentifier = "component_identifier"
        case message
    }
    
    public init(code: String, componentIdentifier: String? = nil, message: String? = nil) {
        self.code = code
        self.componentIdentifier = componentIdentifier
        self.message = message
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.code, forKey: .code)
        try container.encodeIfPresent(self.componentIdentifier, forKey: .componentIdentifier)
        try container.encodeIfPresent(self.message, forKey: .message)
    }
}


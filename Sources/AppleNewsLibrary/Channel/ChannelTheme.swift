//
//  ChannelTheme.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// Theme settings for a channel
public struct ChannelTheme: Codable, Sendable {
    public let headerColor: String?
    public let accentColor: String?
    public let logoImageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case headerColor
        case accentColor
        case logoImageURL = "logoImageUrl"
    }
    
    public init(headerColor: String? = nil, accentColor: String? = nil, logoImageURL: String? = nil) {
        self.headerColor = headerColor
        self.accentColor = accentColor
        self.logoImageURL = logoImageURL
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.headerColor = try container.decodeIfPresent(String.self, forKey: .headerColor)
        self.accentColor = try container.decodeIfPresent(String.self, forKey: .accentColor)
        self.logoImageURL = try container.decodeIfPresent(String.self, forKey: .logoImageURL)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.headerColor, forKey: .headerColor)
        try container.encodeIfPresent(self.accentColor, forKey: .accentColor)
        try container.encodeIfPresent(self.logoImageURL, forKey: .logoImageURL)
    }
}

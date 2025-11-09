//
//  ChannelLinks.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// Links related to a channel resource
public struct ChannelLinks: Codable, Sendable {
    public let `self`: String
    public let defaultSection: String?
    
    enum CodingKeys: CodingKey {
        case `self`
        case defaultSection
    }
    
    public init (self value: String,defaultSection: String? = nil) {
        self.`self` = value
        self.defaultSection = defaultSection
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.`self` = try container.decode(String.self, forKey: .`self`)
        self.defaultSection = try container.decodeIfPresent(String.self, forKey: .defaultSection)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.self, forKey: .`self`)
        try container.encodeIfPresent(self.defaultSection, forKey: .defaultSection)
    }
}

//
//  SectionLinks.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// Links related to a section resource
public struct SectionLinks: Codable, Sendable {
    public let `self`: String
    public let channel: String
    
    enum CodingKeys: CodingKey {
        case `self`
        case channel
    }
    
    public init(sectionId: String, channelId: String) {
        self.`self` = "/sections/\(sectionId)"
        self.channel = "/channels/\(channelId)"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.`self` = try container.decode(String.self, forKey: .`self`)
        self.channel = try container.decode(String.self, forKey: .channel)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.self, forKey: .`self`)
        try container.encode(self.channel, forKey: .channel)
    }
}

//
//  Models.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 3/11/25.
//

import Foundation

/// A channel resource represents a publisher's channel
public struct Channel: Codable, Sendable {
    public let id: UUID
    public let type: String = "channel"
    public let createdAt: Date
    public let modifiedAt: Date
    public let name: String
    public let website: String?
    public let defaultSectionId: String?
    public let shareUrl: String?
    public let links: ChannelLinks
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case createdAt
        case modifiedAt
        case name
        case website
        case defaultSectionId
        case shareUrl
        case links
    }
    
    public init(
        id: UUID,
        createdAt: Date,
        modifiedAt: Date,
        name: String,
        website: String?,
        defaultSectionId: String?,
        shareUrl: String?,
        links: ChannelLinks
    ) {
        self.id = id
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
        self.name = name
        self.website = website
        self.defaultSectionId = defaultSectionId
        self.shareUrl = shareUrl
        self.links = links
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.modifiedAt = try container.decode(Date.self, forKey: .modifiedAt)
        self.name = try container.decode(String.self, forKey: .name)
        self.website = try container.decodeIfPresent(String.self, forKey: .website)
        self.defaultSectionId = try container.decodeIfPresent(String.self, forKey: .defaultSectionId)
        self.shareUrl = try container.decodeIfPresent(String.self, forKey: .shareUrl)
        self.links = try container.decode(ChannelLinks.self, forKey: .links)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.id, forKey: .id)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.modifiedAt, forKey: .modifiedAt)
    }
}


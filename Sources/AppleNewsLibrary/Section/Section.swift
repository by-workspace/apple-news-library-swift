//
//  Sectiojn.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// A section resource represents a section in a channel
public struct Section: Codable, Sendable {
    public let id: String
    public let createdAt: Date
    public let modifiedAt: Date
    public let name: String
    public let isDefault: Bool
    public let links: SectionLinks
    
    enum CodingKeys: String, CodingKey {
        case id, createdAt, modifiedAt, name, isDefault, links
    }
    
    public init(
        id: String,
        createdAt: Date,
        modifiedAt: Date,
        name: String,
        isDefault: Bool,
        links: SectionLinks
    ) {
        self.id = id
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
        self.name = name
        self.isDefault = isDefault
        self.links = links
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.modifiedAt = try container.decode(Date.self, forKey: .modifiedAt)
        self.name = try container.decode(String.self, forKey: .name)
        self.isDefault = try container.decode(Bool.self, forKey: .isDefault)
        self.links = try container.decode(SectionLinks.self, forKey: .links)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(modifiedAt, forKey: .modifiedAt)
        try container.encode(name, forKey: .name)
        try container.encode(isDefault, forKey: .isDefault)
        try container.encode(links, forKey: .links)
    }
}

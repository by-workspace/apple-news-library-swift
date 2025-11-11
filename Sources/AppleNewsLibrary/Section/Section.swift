//
//  Sectiojn.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// A section resource represents a section in a channel
public struct Section: Codable, Sendable {
    public let id: UUID
    public let createdAt: Date
    public let modifiedAt: Date
    public let name: String
    public let isDefault: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, createdAt, modifiedAt, name, isDefault, links
    }
    
    public init(
        id: UUID,
        createdAt: Date,
        modifiedAt: Date,
        name: String,
        isDefault: Bool
    ) {
        self.id = id
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
        self.name = name
        self.isDefault = isDefault
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.modifiedAt = try container.decode(Date.self, forKey: .modifiedAt)
        self.name = try container.decode(String.self, forKey: .name)
        self.isDefault = try container.decode(Bool.self, forKey: .isDefault)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(modifiedAt, forKey: .modifiedAt)
        try container.encode(name, forKey: .name)
        try container.encode(isDefault, forKey: .isDefault)
    }
}

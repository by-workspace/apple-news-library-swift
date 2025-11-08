//
//  Asset.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// An asset resource represents a file uploaded to Apple News
public struct Asset: Codable, Sendable {
    public let id: String
    public let type: String = "asset"
    public let size: Int
    public let contentType: String
    public let links: AssetLinks
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case size
        case contentType
        case links
    }
    
    public init(id: String, size: Int, contentType: String, links: AssetLinks) {
        self.id = id
        self.size = size
        self.contentType = contentType
        self.links = links
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.size = try container.decode(Int.self, forKey: .size)
        self.contentType = try container.decode(String.self, forKey: .contentType)
        self.links = try container.decode(AssetLinks.self, forKey: .links)
    }
}

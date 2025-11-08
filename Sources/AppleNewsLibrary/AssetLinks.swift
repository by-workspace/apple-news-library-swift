//
//  AssetLinks.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 8/11/25.
//

import Foundation

/// Links related to an asset
public struct AssetLinks: Codable, Sendable {
    public let `self`: String
    public let article: String
    
    public init(assetId: String, articleId: String) {
        self.`self` = "/assets/\(assetId)"
        self.article = "/articles/\(articleId)"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.`self` = try container.decode(String.self, forKey: .self)
        self.article = try container.decode(String.self, forKey: .article)
    }
}

//
//  SectionStats.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// Statistics about a section's articles
public struct SectionStats: Codable, Sendable {
    public let totalArticles: Int
    public let liveArticles: Int
    public let draftArticles: Int
    
    enum CodingKeys: String, CodingKey {
        case totalArticles = "total_articles"
        case liveArticles = "live_articles"
        case draftArticles = "draft_articles"
    }
    
    public init(totalArticles: Int, liveArticles: Int, draftArticles: Int) {
        self.totalArticles = totalArticles
        self.liveArticles = liveArticles
        self.draftArticles = draftArticles
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.totalArticles = try container.decode(Int.self, forKey: .totalArticles)
        self.liveArticles = try container.decode(Int.self, forKey: .liveArticles)
        self.draftArticles = try container.decode(Int.self, forKey: .draftArticles)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.totalArticles, forKey: .totalArticles)
        try container.encode(self.liveArticles, forKey: .liveArticles)
        try container.encode(self.draftArticles, forKey: .draftArticles)
    }
}

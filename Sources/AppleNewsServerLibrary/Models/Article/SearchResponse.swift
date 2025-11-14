//
//  SearchResult.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// A search result containing articles matching the query
public struct SearchResponse: Codable, Sendable {
    public let articles: [Article]
    public let links: SearchResponseLinks?
    public let meta: SearchMeta
    
    enum CodingKeys: CodingKey {
        case data
        case links
        case meta
    }
    
    public init(data: [Article], links: SearchResponseLinks? = nil, meta: SearchMeta) {
        self.articles = data
        self.links = links
        self.meta = meta
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.articles = try container.decode([Article].self, forKey: .data)
        self.links = try container.decodeIfPresent(SearchResponseLinks.self, forKey: .links)
        self.meta = try container.decode(SearchMeta.self, forKey: .meta)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.articles, forKey: .data)
        try container.encode(self.links, forKey: .links)
        try container.encode(self.meta, forKey: .meta)
    }
}


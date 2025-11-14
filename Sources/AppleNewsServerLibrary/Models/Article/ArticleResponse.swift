//
//  ArticleResponse.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// Response containing multiple articles
public struct ArticleResponse: Codable, Sendable {
    public let article: Article
    public let links: ArticleLinksResponse?
    public let meta: Meta?
    public let metadata: CreateArticleMetadata?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    public init(
        article: Article,
        links: ArticleLinksResponse? = nil,
        meta: Meta? = nil,
        metadata: CreateArticleMetadata? = nil
    ) {
        self.article = article
        self.links = links
        self.meta = meta
        self.metadata = metadata
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dataDecoder = try container.superDecoder(forKey: .data)
        
        self.article = try Article(from: dataDecoder)
        self.links = try? ArticleLinksResponse(from: dataDecoder)
        self.meta = try? Meta(from: dataDecoder)
        self.metadata = try? CreateArticleMetadata(from: dataDecoder)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        let dataEncoder = container.superEncoder(forKey: .data)
        
        try article.encode(to: dataEncoder)
        try links?.encode(to: dataEncoder)
        try meta?.encode(to: dataEncoder)
        try metadata?.encode(to: dataEncoder)
    }
}

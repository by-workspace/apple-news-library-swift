//
//  ArticleUpdate.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation
 
/// Parameters for updating an article
public struct UpdateArticleMetadata: Codable, Sendable {
    public let revision: String?
    public let isPreview: Bool?
    public let isSponsored: Bool?
    public let isHidden: Bool?
    public let isCandidateToBeFeatured: Bool?
    public let maturityRating: Article.MaturityRating?
    public let accessLevel: Article.AccessLevel?
    public let links: ArticleUpdateLinks?
    
    enum CodingKeys: String, CodingKey {
        case revision,
             document,
             metadata,
             isPreview,
             isSponsored,
             isHidden,
             isCandidateToBeFeatured,
             maturityRating,
             accessLevel,
             links
    }
    
    public init(
        revision: String? = nil,
        isPreview: Bool? = nil,
        isSponsored: Bool? = nil,
        isHidden: Bool? = nil,
        isCandidateToBeFeatured: Bool? = nil,
        maturityRating: Article.MaturityRating? = nil,
        accessLevel: Article.AccessLevel? = nil,
        links: ArticleUpdateLinks? = nil
    ) {
        self.revision = revision
        self.isPreview = isPreview
        self.isSponsored = isSponsored
        self.isHidden = isHidden
        self.isCandidateToBeFeatured = isCandidateToBeFeatured
        self.maturityRating = maturityRating
        self.accessLevel = accessLevel
        self.links = links
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.revision = try container.decodeIfPresent(String.self, forKey: .revision)
        self.isPreview = try container.decodeIfPresent(Bool.self, forKey: .isPreview)
        self.isSponsored = try container.decodeIfPresent(Bool.self, forKey: .isSponsored)
        self.isHidden = try container.decodeIfPresent(Bool.self, forKey: .isHidden)
        self.isCandidateToBeFeatured = try container.decodeIfPresent(Bool.self, forKey: .isCandidateToBeFeatured)
        self.maturityRating = try container.decodeIfPresent(Article.MaturityRating.self, forKey: .maturityRating)
        self.accessLevel = try container.decodeIfPresent(Article.AccessLevel.self, forKey: .accessLevel)
        self.links = try container.decodeIfPresent(ArticleUpdateLinks.self, forKey: .links)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(revision, forKey: .revision)
        try container.encodeIfPresent(isPreview, forKey: .isPreview)
        try container.encodeIfPresent(isSponsored, forKey: .isSponsored)
        try container.encodeIfPresent(isHidden, forKey: .isHidden)
        try container.encodeIfPresent(isCandidateToBeFeatured, forKey: .isCandidateToBeFeatured)
    }
}




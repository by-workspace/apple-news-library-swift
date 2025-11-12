//
//  Articles.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

public struct Article: Sendable, Codable {
    public let id: String
    public let title: String
    public let type: String = "article"
    public let createdAt: Date
    public let modifiedAt: Date
    public let shareURL: String
    public let revision: String
    public let document: Data?
    public let state: State
    public let accessLevel: AccessLevel?
    public let maturityRating: MaturityRating?
    public let links: ArticleLinksResponse
    public let isSponsored: Bool
    public let isPreview: Bool
    public let isHidden: Bool
    public let isCandidateToBeFeatured: Bool
    public let isPaid: Bool

    /// The state of an article
    public enum State: String, Codable, Sendable {
        case live = "LIVE"
        case draft = "DRAFT"
        case takedown = "TAKEDOWN"
    }
    
    /// Article access level
    public enum AccessLevel: String, Codable, Sendable {
        case `public` = "PUBLIC"
        case protected = "PROTECTED"
    }
    
    /// Article maturity rating
    public enum MaturityRating: String, Codable, Sendable {
        case general = "GENERAL"
        case mature = "MATURE"
        case kids = "KIDS"
    }
   
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case type
        case createdAt
        case modifiedAt
        case shareURL = "shareUrl"
        case revision
        case document
        case state
        case accessLevel
        case maturityRating
        case links
        case isSponsored
        case isPreview
        case isHidden
        case isCandidateToBeFeatured
        case isPaid
    }
    
    public init(
        id: String,
        title: String,
        createdAt: Date,
        modifiedAt: Date,
        shareURL: String,
        revision: String,
        document: Data?,
        state: State,
        accessLevel: AccessLevel?,
        maturityRating: MaturityRating?,
        links: ArticleLinksResponse,
        isSponsored: Bool,
        isPreview: Bool,
        isHidden: Bool,
        isCandidateToBeFeatured: Bool,
        isPaid: Bool
    ) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
        self.shareURL = shareURL
        self.revision = revision
        self.document = document
        self.state = state
        self.accessLevel = accessLevel
        self.maturityRating = maturityRating
        self.links = links
        self.isSponsored = isSponsored
        self.isPreview = isPreview
        self.isHidden = isHidden
        self.isCandidateToBeFeatured = isCandidateToBeFeatured
        self.isPaid = isPaid
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.modifiedAt = try container.decode(Date.self, forKey: .modifiedAt)
        self.shareURL = try container.decode(String.self, forKey: .shareURL)
        self.revision = try container.decode(String.self, forKey: .revision)
        self.state = try container.decode(Article.State.self, forKey: .state)
        self.document = try container.decodeIfPresent(Data.self, forKey: .document)
        self.accessLevel = try container.decodeIfPresent(Article.AccessLevel.self, forKey: .accessLevel)
        self.maturityRating = try container.decodeIfPresent(Article.MaturityRating.self, forKey: .maturityRating)
        self.links = try container.decode(ArticleLinksResponse.self, forKey: .links)
        self.isSponsored = try container.decode(Bool.self, forKey: .isSponsored)
        self.isPreview = try container.decode(Bool.self, forKey: .isPreview)
        self.isHidden = try container.decode(Bool.self, forKey: .isHidden)
        self.isCandidateToBeFeatured = try container.decode(Bool.self, forKey: .isCandidateToBeFeatured)
        self.isPaid = try container.decode(Bool.self, forKey: .isPaid)
        self.title = try container.decode(String.self, forKey: .title)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.id, forKey: .id)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.modifiedAt, forKey: .modifiedAt)
        try container.encode(self.shareURL, forKey: .shareURL)
        try container.encode(self.revision, forKey: .revision)
        try container.encode(self.document, forKey: .document)
        try container.encode(self.state, forKey: .state)
        try container.encodeIfPresent(self.accessLevel, forKey: .accessLevel)
        try container.encodeIfPresent(self.maturityRating, forKey: .maturityRating)
        try container.encode(self.links, forKey: .links)
        try container.encode(self.isSponsored, forKey: .isSponsored)
        try container.encode(self.isPreview, forKey: .isPreview)
        try container.encode(self.isHidden, forKey: .isHidden)
        try container.encode(self.isCandidateToBeFeatured, forKey: .isCandidateToBeFeatured)
        try container.encode(self.isPaid, forKey: .isPaid)
        try container.encode(self.title, forKey: .title)
    }
}

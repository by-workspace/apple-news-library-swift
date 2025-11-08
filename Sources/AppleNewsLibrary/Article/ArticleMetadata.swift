//
//  ArticleMetadata.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 8/11/25.
//

import Foundation

/// Metadata for article updates
public struct ArticleMetadata: Codable, Sendable {
    public let title: String?
    public let excerpt: String?
    public let canonicalURL: String?
    public let keywords: [String]?
    public let thumbnailURL: String?
    public let transparentToolbar: Bool?
    public let videoURL: String?
    public let datePublished: Date?
    public let dateCreated: Date?
    public let dateModified: Date?
    public let authors: [String]?
    public let campaignData: CampaignData?
    
    enum CodingKeys: String, CodingKey {
        case title
        case excerpt
        case canonicalURL = "canonicalUrl"
        case keywords
        case thumbnailURL = "thumbnailUrl"
        case transparentToolbar
        case videoURL = "videoUrl"
        case datePublished
        case dateCreated
        case dateModified
        case authors
        case campaignData
    }

    public init(
        title: String?,
        excerpt: String?,
        canonicalURL: String?,
        keywords: [String]?,
        thumbnailURL: String?,
        transparentToolbar: Bool?,
        videoURL: String?,
        datePublished: Date?,
        dateCreated: Date?,
        dateModified: Date?,
        authors: [String]?,
        campaignData: CampaignData?
    ) {
        self.title = title
        self.excerpt = excerpt
        self.canonicalURL = canonicalURL
        self.keywords = keywords
        self.thumbnailURL = thumbnailURL
        self.transparentToolbar = transparentToolbar
        self.videoURL = videoURL
        self.datePublished = datePublished
        self.dateCreated = dateCreated
        self.dateModified = dateModified
        self.authors = authors
        self.campaignData = campaignData
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.excerpt = try container.decodeIfPresent(String.self, forKey: .excerpt)
        self.canonicalURL = try container.decodeIfPresent(String.self, forKey: .canonicalURL)
        self.keywords = try container.decodeIfPresent([String].self, forKey: .keywords)
        self.thumbnailURL = try container.decodeIfPresent(String.self, forKey: .thumbnailURL)
        self.transparentToolbar = try container.decodeIfPresent(Bool.self, forKey: .transparentToolbar)
        self.videoURL = try container.decodeIfPresent(String.self, forKey: .videoURL)
        self.datePublished = try container.decodeIfPresent(Date.self, forKey: .datePublished)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.dateModified = try container.decodeIfPresent(Date.self, forKey: .dateModified)
        self.authors = try container.decodeIfPresent([String].self, forKey: .authors)
        self.campaignData = try container.decodeIfPresent(CampaignData.self, forKey: .campaignData)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(excerpt, forKey: .excerpt)
        try container.encodeIfPresent(canonicalURL, forKey: .canonicalURL)
    }
}

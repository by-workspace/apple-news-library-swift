//
//  SectionMetrics.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// Metrics and analytics data for a section
public struct SectionMetrics: Codable, Sendable {
    public let sectionId: String
    public let totalArticles: Int
    public let liveArticles: Int
    public let draftArticles: Int
    public let totalImpressions: Int
    public let totalEngagements: Int
    public let period: MetricsPeriod
    
    enum CodingKeys: String, CodingKey {
        case sectionId
        case totalArticles
        case liveArticles
        case draftArticles
        case totalImpressions
        case totalEngagements
        case period
    }
    
    public init(
        sectionId: String,
        totalArticles: Int,
        liveArticles: Int,
        draftArticles: Int,
        totalImpressions: Int,
        totalEngagements: Int,
        period: MetricsPeriod
    ) {
        self.sectionId = sectionId
        self.totalArticles = totalArticles
        self.liveArticles = liveArticles
        self.draftArticles = draftArticles
        self.totalImpressions = totalImpressions
        self.totalEngagements = totalEngagements
        self.period = period
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.sectionId = try container.decode(String.self, forKey: .sectionId)
        self.totalArticles = try container.decode(Int.self, forKey: .totalArticles)
        self.liveArticles = try container.decode(Int.self, forKey: .liveArticles)
        self.draftArticles = try container.decode(Int.self, forKey: .draftArticles)
        self.totalImpressions = try container.decode(Int.self, forKey: .totalImpressions)
        self.totalEngagements = try container.decode(Int.self, forKey: .totalEngagements)
        self.period = try container.decode(MetricsPeriod.self, forKey: .period)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.sectionId, forKey: .sectionId)
        try container.encode(self.totalArticles, forKey: .totalArticles)
        try container.encode(self.liveArticles, forKey: .liveArticles)
        try container.encode(self.draftArticles, forKey: .draftArticles)
    }
}

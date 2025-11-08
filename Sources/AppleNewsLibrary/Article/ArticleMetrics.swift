//
//  ArticleMetrics.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// Metrics and analytics data for an article
public struct ArticleMetrics {
    public let articleId: String
    public let impressions: Int
    public let engagements: Int
    public let completions: Int
    public let averageReadTime: Double?
    public let period: MetricsPeriod
    
    enum CodingKeys: String, CodingKey {
        case articleId
        case impressions
        case engagements
        case completions
        case averageReadTime
        case period
    }
    
    public init(
        articleId: String,
        impressions: Int,
        engagements: Int,
        completions: Int,
        averageReadTime: Double?,
        period: MetricsPeriod
    ) {
        self.articleId = articleId
        self.impressions = impressions
        self.engagements = engagements
        self.completions = completions
        self.averageReadTime = averageReadTime
        self.period = period
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.articleId = try values.decode(String.self, forKey:.articleId)
        self.impressions = try values.decode(Int.self, forKey:.impressions)
        self.engagements =  try values.decode(Int.self, forKey:.engagements)
        self.completions =  try values.decode(Int.self, forKey:.completions)
        self.averageReadTime =  try values.decodeIfPresent(Double.self, forKey:.impressions)
        self.period = try values.decode(MetricsPeriod.self, forKey:.period)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.articleId, forKey: .articleId)
        try container.encode(self.impressions, forKey: .impressions)
        try container.encode(self.engagements, forKey: .engagements)
        try container.encode(self.completions, forKey: .completions)
    }
}

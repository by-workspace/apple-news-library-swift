//
//  ChannelMetrics.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// Metrics and analytics data for a channel
public struct ChannelMetrics: Codable, Sendable {
    let channelId: String
    let totalArticles: Int
    let liveArticles: Int
    let draftArticles: Int
    let totalImpressions: Int
    let totalEngagements: Int
    let period: MetricsPeriod
    
    enum CodingKeys: String, CodingKey {
        case channelId 
        case totalArticles
        case liveArticles
        case draftArticles
        case totalImpressions
        case totalEngagements
        case period
    }
}


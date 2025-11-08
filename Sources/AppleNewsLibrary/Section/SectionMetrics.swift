//
//  SectionMetrics.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// Metrics and analytics data for a section
public struct SectionMetrics: Codable, Sendable {
    let sectionId: String
    let totalArticles: Int
    let liveArticles: Int
    let draftArticles: Int
    let totalImpressions: Int
    let totalEngagements: Int
    let period: MetricsPeriod
    
    enum CodingKeys: String, CodingKey {
        case sectionId
        case totalArticles
        case liveArticles
        case draftArticles
        case totalImpressions
        case totalEngagements
        case period
    }
}

//
//  ReadingPosition.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// Represents a user's reading position in an article
public struct ReadingPosition: Sendable, Codable {
    let articleId: String
    let position: Int
    let modifiedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case articleId
        case position
        case modifiedAt
    }
    
    init(articleId: String, position: Int, modifiedAt: Date) {
        self.articleId = articleId
        self.position = position
        self.modifiedAt = modifiedAt
    }
}

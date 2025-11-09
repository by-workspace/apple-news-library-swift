//
//  SearchResult.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// A search result containing articles matching the query
public struct SearchResult: Codable, Sendable {
    public let data: [Article]
    public let meta: SearchMeta
    
    public init(data: [Article], meta: SearchMeta) {
        self.data = data
        self.meta = meta
    }
}

/// Metadata about search results
public struct SearchMeta: Codable, Sendable {
    public let total: Int
    
    public init(total: Int) {
        self.total = total
    }
}

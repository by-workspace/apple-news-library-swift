//
//  SearchMeta.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 11/11/25.
//

/// Metadata about search results
public struct SearchMeta: Codable, Sendable {
    public let nextPageToken: Int
    
    public init(total: Int) {
        self.nextPageToken = total
    }
}

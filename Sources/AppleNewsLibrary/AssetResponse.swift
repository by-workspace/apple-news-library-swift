//
//  AssetResponse.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// Response containing multiple assets
public struct AssetsResponse: Sendable, Codable {
    public let data: [Asset]
    public let meta: ResponseMeta?
}

public struct ResponseMeta: Sendable, Codable {
    public let totalCount: Int
    
    public init(totalCount: Int) {
        self.totalCount = totalCount
    }
}

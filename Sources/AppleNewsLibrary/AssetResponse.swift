//
//  AssetResponse.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// Response containing multiple assets
public struct AssetsResponse: Sendable, Codable {
    let data: [Asset]
    let meta: ResponseMeta?
}

public struct ResponseMeta: Sendable, Codable {
    let totalCount: Int
}

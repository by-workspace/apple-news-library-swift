//
//  AssetLinks.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 8/11/25.
//

import Foundation

/// Links related to an asset
struct AssetLinks: Codable, Sendable {
    let `self`: String
    let article: String
    
    init(assetId: String, articleId: String) {
        self.`self` = "/assets/\(assetId)"
        self.article = "/articles/\(articleId)"
    }
}

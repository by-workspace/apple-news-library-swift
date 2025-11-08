//
//  ArticleResponse.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// Response containing multiple articles
public struct ArticlesResponse: Codable, Sendable {
    public let data: [Article]
    public let meta: ResponseMeta?
    
    public init(data: [Article], meta: ResponseMeta?) {
        self.data = data
        self.meta = meta
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.data = try container.decode([Article].self, forKey: .data)
        self.meta = try container.decodeIfPresent(ResponseMeta.self, forKey: .meta)
    }
}

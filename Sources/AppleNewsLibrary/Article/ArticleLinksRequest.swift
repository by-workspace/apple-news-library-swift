//
//  ArticleUpdateLinks.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 8/11/25.
//

import Foundation

/// Links for article updates
public struct ArticleUpdateLinks: Codable, Sendable {
    public let sections: [String]
    
    public init(sections: [String]) {
        self.sections = sections
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.sections = try container.decode([String].self, forKey: .sections)
    }
}

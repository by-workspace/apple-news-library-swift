//
//  ArticleUpdateLinks.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 8/11/25.
//

import Foundation

/// Links for article updates
public struct ArticleUpdateLinks: Codable, Sendable {
    public let sections: [String]?
    
    public init(sectionIDs: [String]? = nil) {
        self.sections = sectionIDs?.map { "/sections/\($0)" }
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.sections = try container.decodeIfPresent([String].self, forKey: .sections)
    }
}

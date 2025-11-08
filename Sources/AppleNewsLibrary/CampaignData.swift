//
//  CampaignData.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 8/11/25.
//

import Foundation

/// Campaign tracking data
public struct CampaignData: Codable, Sendable {
    public let name: String?
    public let source: String?
    public let medium: String?
    
    public init(name: String? = nil, source: String? = nil, medium: String? = nil) {
        self.name = name
        self.source = source
        self.medium = medium
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.source = try container.decodeIfPresent(String.self, forKey: .source)
        self.medium = try container.decodeIfPresent(String.self, forKey: .medium)
    }
}

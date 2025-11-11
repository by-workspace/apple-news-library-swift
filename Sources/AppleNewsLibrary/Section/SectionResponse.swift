//
//  SectionResponse.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// Response containing a single section
public struct SectionResponse: Codable, Sendable {
    public let section: Section
    public let links: SectionLinks?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    public init(section: Section, links: SectionLinks?) {
        self.section = section
        self.links = links
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dataDecoder = try container.superDecoder(forKey: .data)
        
        self.section = try Section(from: dataDecoder)
        self.links = try? SectionLinks(from: dataDecoder)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        let dataEncoder = container.superEncoder(forKey: .data)
        
        try section.encode(to: dataEncoder)
        try links?.encode(to: dataEncoder)
    }
}


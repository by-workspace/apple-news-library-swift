//
//  SectionsResponse.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 11/11/25.
//

/// Response containing multiple sections with flattened section and links
public struct SectionsResponse: Codable, Sendable {
    public let sections: [SectionResponse]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    public init(sections: [SectionResponse]) {
        self.sections = sections
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var dataContainer = try container.nestedUnkeyedContainer(forKey: .data)
        
        var sections: [SectionResponse] = []
        
        while !dataContainer.isAtEnd {
            let sectionDecoder = try dataContainer.superDecoder()
            let section = try Section(from: sectionDecoder)
            let links = try? SectionLinks(from: sectionDecoder)
            
            sections.append(SectionResponse(section: section, links: links))
        }
        
        self.sections = sections
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var dataContainer = container.nestedUnkeyedContainer(forKey: .data)
        
        for sectionResponse in sections {
            let sectionEncoder = dataContainer.superEncoder()
            try sectionResponse.section.encode(to: sectionEncoder)
            try sectionResponse.links?.encode(to: sectionEncoder)
        }
    }
}

//
//  SectionUpdate.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// Parameters for updating a section
public struct SectionUpdate: Codable, Sendable {
    public let name: String?
    public let isDefault: Bool?
    
    enum CodingKeys: String, CodingKey {
        case name
        case isDefault = "is_default"
    }
    
    public init(name: String? = nil, isDefault: Bool? = nil) {
        self.name = name
        self.isDefault = isDefault
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.isDefault = try container.decodeIfPresent(Bool.self, forKey: .isDefault)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.isDefault, forKey: .isDefault)
    }
}

//
//  SectionResponse.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// Response containing multiple sections
public struct SectionsResponse {
    public let data: [Section]
    public let meta: ResponseMeta?
    
    enum CodingKeys: String, CodingKey {
        case data, meta
    }
    
    public init(data: [Section], meta: ResponseMeta?) {
        self.data = data
        self.meta = meta
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try values.decode([Section].self, forKey: .data)
        self.meta = try values.decodeIfPresent(ResponseMeta.self, forKey: .meta)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try container.encodeIfPresent(meta, forKey: .meta)
    }
}

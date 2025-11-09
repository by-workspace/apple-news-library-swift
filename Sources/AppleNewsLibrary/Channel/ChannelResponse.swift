//
//  ChannelResponse.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation
 
/// Response containing multiple channels
public struct ChannelsResponse: Codable, Sendable {
    public let data: [Channel]
    public let meta: Meta?

    enum CodingKeys: CodingKey {
        case data
        case meta
    }
    
    public init(data: [Channel], meta: Meta? = nil) {
        self.data = data
        self.meta = meta
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
         
        self.data = try container.decode([Channel].self, forKey: .data)
        self.meta = try container.decodeIfPresent(Meta.self, forKey: .meta)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.data, forKey: .data)
        try container.encodeIfPresent(self.meta, forKey: .meta)
    }
}

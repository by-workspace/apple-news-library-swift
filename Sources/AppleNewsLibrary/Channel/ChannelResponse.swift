//
//  ChannelResponse.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation
 
/// Response containing multiple channels
public struct ChannelResponse: Codable, Sendable {
    public let channel: Channel
    public let links: ChannelLinks?

    enum CodingKeys: CodingKey {
        case data
    }
    
    public init(channel: Channel, links: ChannelLinks? = nil) {
        self.channel = channel
        self.links = links
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dataDecoder = try container.superDecoder(forKey: .data)
        
        self.channel = try Channel(from: dataDecoder)
        self.links = try? ChannelLinks(from: dataDecoder)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        let dataEncoder = container.superEncoder(forKey: .data)
        
        try channel.encode(to: dataEncoder)
        try links?.encode(to: dataEncoder)
    }
}

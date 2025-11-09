//
//  ArticleLinks.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

public struct ArticleLinksResponse: Codable, Sendable {
    public let `self`: String
    public let channel: String
    public let sections: [String]
    
    enum CodingKeys: CodingKey {
        case `self`
        case channel
        case sections
    }
    
    public init (self value: String, channel: String, sections: [String]) {
        self.`self` = value
        self.channel = channel
        self.sections = sections
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.`self` = try container.decode(String.self, forKey: .`self`)
        self.channel = try container.decode(String.self, forKey: .channel)
        self.sections = try container.decode([String].self, forKey: .sections)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.self, forKey: .`self`)
        try container.encode(self.channel, forKey: .channel)
        try container.encode(self.sections, forKey: .sections)
    }
}

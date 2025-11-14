//
//  ArticleLinks.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

public struct SearchResponseLinks: Codable, Sendable {
    public let `self`: String
    public let next: String
    
    enum CodingKeys: CodingKey {
        case `self`
        case next
    }
    
    public init (self value: String, next: String) {
        self.`self` = value
        self.next = next
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.`self` = try container.decode(String.self, forKey: .`self`)
        self.next = try container.decode(String.self, forKey: .next)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.`self`, forKey: .`self`)
        try container.encode(self.next, forKey: .next)
    }
}

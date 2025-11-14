//
//  Meta.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 9/11/25.
//

public struct Meta: Sendable, Codable {
    public let throttling: Throttling
    
    public init(throttling: Throttling) {
        self.throttling = throttling
    }
}

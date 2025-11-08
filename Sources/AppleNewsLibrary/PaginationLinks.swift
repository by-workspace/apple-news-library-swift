//
//  PaginationLinks.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// Links for navigating paginated results
public struct PaginationLinks: Codable, Sendable {
    public let `self`: String
    public let next: String?
    public let prev: String?
    
    public init(selfLink: String, next: String? = nil, prev: String? = nil) {
        self.`self` = selfLink
        self.next = next
        self.prev = prev
    }
}

//
//  Sectiojn.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// A section resource represents a section in a channel
public struct Section: Codable, Sendable {
    let id: String
    let createdAt: Date
    let modifiedAt: Date
    let name: String
    let isDefault: Bool
    let links: SectionLinks
}

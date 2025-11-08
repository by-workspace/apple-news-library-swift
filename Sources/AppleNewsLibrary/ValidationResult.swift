//
//  ValidationResult.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 5/11/25.
//

import Foundation

/// Result of validating an article document
public struct ValidationResult: Codable, Sendable {
    let isValid: Bool
    let warnings: [ArticleIssue]?
    let errors: [ArticleIssue]?
    
    init(isValid: Bool, warnings: [ArticleIssue]? = nil, errors: [ArticleIssue]? = nil) {
        self.isValid = isValid
        self.warnings = warnings
        self.errors = errors
    }
}

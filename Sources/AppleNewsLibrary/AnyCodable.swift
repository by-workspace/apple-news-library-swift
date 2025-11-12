//
//  AnyCodable.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 12/11/25.
//

import Foundation

// Helper to decode [String: Any] dictionaries
struct AnyCodable: Codable {
    let value: Any
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let dict = try? container.decode([String: AnyCodable].self) {
            self.value = dict.mapValues { $0.value }
        } else if let array = try? container.decode([AnyCodable].self) {
            self.value = array.map { $0.value }
        } else if let string = try? container.decode(String.self) {
            self.value = string
        } else if let number = try? container.decode(Double.self) {
            self.value = number
        } else if let bool = try? container.decode(Bool.self) {
            self.value = bool
        } else {
            self.value = NSNull()
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        if let dict = value as? [String: Any] {
            try container.encode(dict.mapValues { AnyCodable(value: $0) })
        } else if let array = value as? [Any] {
            try container.encode(array.map { AnyCodable(value: $0) })
        } else if let string = value as? String {
            try container.encode(string)
        } else if let number = value as? Double {
            try container.encode(number)
        } else if let number = value as? Int {
            try container.encode(number)
        } else if let bool = value as? Bool {
            try container.encode(bool)
        } else {
            try container.encodeNil()
        }
    }
    
    init(value: Any) {
        self.value = value
    }
}

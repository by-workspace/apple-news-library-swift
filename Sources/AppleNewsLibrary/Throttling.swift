//
//  Throttling.swift
//  AppleNewsLibrary
//
//  Created by Axel Martinez on 9/11/25.
//

public struct Throttling: Sendable, Codable {
    var estimatedDelayInSecondsinteger: Int
    var isThrottled: Bool = false
    var queueSize: Int  = 0
    var quotaAvailable: Int
}

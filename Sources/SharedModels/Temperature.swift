//
//  Temperature.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Foundation

public struct Temperature: Codable, Hashable {

    public let min: Int
    public let max: Int

    public init(min: Int, max: Int) {
        self.min = min
        self.max = max
    }
}

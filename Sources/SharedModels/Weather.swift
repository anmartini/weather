//
//  Weather.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Foundation

public struct Weather: Codable, Hashable {
    public let value: String
    public let text: WeatherText

    public init(value: String, text: WeatherText) {
        self.value = value
        self.text = text
    }
}

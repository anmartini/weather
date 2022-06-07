//
//  ZoneForecast.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Foundation

public struct ZoneForecast: Codable, Hashable {

    public let rain: String?
    public let wind: Int
    public let temperature: Temperature

    public init(
        rain: String?,
        wind: Int,
        temperature: Temperature
    ) {
        self.rain = rain
        self.wind = wind
        self.temperature = temperature
    }
}

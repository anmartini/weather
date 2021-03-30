//
//  Zone.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Foundation

// MARK: - Zone
public struct Zone: Codable, Identifiable, Hashable {

    public let id = UUID()
    public let code: String
    public let name: String
    public let forecast: ZoneForecast?
    public let times: [ZoneTime]
    
    enum CodingKeys: String, CodingKey {
        case code, name, forecast, times
    }

    public init(code: String,
                name: String,
                forecast: ZoneForecast?,
                times: [ZoneTime]) {
        self.code = code
        self.name = name
        self.forecast = forecast
        self.times = times
    }
}

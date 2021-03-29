//
//  Zone.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Foundation

// MARK: - Zone
struct Zone: Codable, Identifiable, Hashable {
    let id = UUID()
    let code, name: String
    let forecast: ZoneForecast?
    let times: [ZoneTime]
    
    enum CodingKeys: String, CodingKey {
        case code, name, forecast, times
    }
}

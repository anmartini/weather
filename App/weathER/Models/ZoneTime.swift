//
//  ZoneTime.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Foundation

struct ZoneTime: Codable, Identifiable, Hashable {
    let id = UUID()
    let weather: Weather
    
    enum CodingKeys: String, CodingKey {
        case weather
    }
}

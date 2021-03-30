//
//  ZoneTime.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Foundation

public struct ZoneTime: Codable, Identifiable, Hashable {
    public let id = UUID()
    public let weather: Weather
    
    enum CodingKeys: String, CodingKey {
        case weather
    }
}

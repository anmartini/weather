//
//  ZoneForecast.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Foundation

struct ZoneForecast: Codable, Hashable {
    let rain: String?
    let wind: Int
    let temperature: Temperature
}

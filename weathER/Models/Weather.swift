//
//  Weather.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Foundation

struct Weather: Codable, Hashable {
    let value: String
    let text: WeatherText
}

//
//  WeatherText.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Foundation

public struct WeatherText: Codable, Hashable {
    public let it: String
    public let en: String

    public init(it: String, en: String) {
        self.it = it
        self.en = en
    }
}

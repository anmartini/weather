// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let forecast = try? newJSONDecoder().decode(Forecast.self, from: jsonData)

import Foundation

// MARK: - RegionalForecast
public struct RegionalForecast: Codable, Hashable {
    public let weather: String
    public let temperature: String
    public let wind: String
    public let sea: String

    public init(
        weather: String,
        temperature: String,
        wind: String,
        sea: String
    ) {
        self.weather = weather
        self.temperature = temperature
        self.wind = wind
        self.sea = sea
    }
}

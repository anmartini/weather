// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let forecast = try? newJSONDecoder().decode(Forecast.self, from: jsonData)

import Foundation

// MARK: - RegionalForecast
struct RegionalForecast: Codable, Hashable {
    let weather, temperature, wind, sea: String
}

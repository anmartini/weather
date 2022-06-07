// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let regionalDay = try? newJSONDecoder().decode(RegionalDay.self, from: jsonData)

import Foundation

// MARK: - RegionalDay
public struct RegionalDay: Codable, Identifiable, Hashable {
    public let id = UUID()
    public let day: Date
    public let forecast: RegionalForecast
    public let updatedAt: Date

    public var readableDay: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE d MMMM")

        return dateFormatter.string(from: day)
    }

    public var readableUpdatedAt: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy HH:mm:ss")

        return dateFormatter.string(from: updatedAt)
    }

    enum CodingKeys: String, CodingKey {
        case day, forecast
        case updatedAt = "updated_at"
    }

    public init(
        day: Date,
        forecast: RegionalForecast,
        updatedAt: Date
    ) {
        self.day = day
        self.forecast = forecast
        self.updatedAt = updatedAt
    }
}

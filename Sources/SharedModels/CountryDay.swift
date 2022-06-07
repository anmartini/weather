//
//  CountryDay.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Foundation

// MARK: - CountryDay
public struct CountryDay: Codable, Identifiable, Hashable {

    public let id = UUID()
    public let day: Date
    public let forecast: String
    public let updatedAt: Date
    public let zones: [Zone]

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
        case day, forecast, zones
        case updatedAt = "updated_at"
    }

    public init(
        day: Date,
        forecast: String,
        updatedAt: Date,
        zones: [Zone]
    ) {
        self.day = day
        self.forecast = forecast
        self.updatedAt = updatedAt
        self.zones = zones
    }
}

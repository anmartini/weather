//
//  CountryDay.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Foundation

// MARK: - CountryDay
struct CountryDay: Codable, Identifiable, Hashable {
    let id = UUID()
    let day: Date
    let forecast: String
    let updatedAt: Date
    
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
}

//
//  Country.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Foundation

// MARK: - Country
struct Country: Codable, Identifiable, Hashable {
    let id = UUID()
    let code, name: String
    
    enum CodingKeys: String, CodingKey {
        case code, name
    }
}

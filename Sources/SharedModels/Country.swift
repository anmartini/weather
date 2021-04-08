//
//  Country.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Foundation

// MARK: - Country
public struct Country: Codable, Identifiable, Hashable {

    public let id = UUID()
    public let code: String
    public let name: String
    
    enum CodingKeys: String, CodingKey {
        case code, name
    }

    public init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}

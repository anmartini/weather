//
//  Environment.swift
//  weathER
//
//  Created by Roberto Casula on 28/02/21.
//

import Foundation

struct Environment {
        
    let baseUrl: String
    
    public static var current: Environment = {
        .init(baseUrl: "https://meteo.kyntos.it/api")
    }()
}

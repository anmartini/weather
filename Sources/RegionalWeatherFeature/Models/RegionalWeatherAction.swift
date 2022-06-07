//
//  RegionalWeatherAction.swift
//
//
//  Created by Roberto Casula on 03/04/21.
//

import Foundation
import SharedModels

public enum RegionalWeatherAction: Equatable {
    case onAppear
    case loadWeather(days: [String])
    case regionalDaysResponse(Result<[RegionalDay], ApiError>)
}

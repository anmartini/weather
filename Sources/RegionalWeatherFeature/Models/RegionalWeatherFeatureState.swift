//
//  RegionalWeatherFeatureState.swift
//  
//
//  Created by Roberto Casula on 03/04/21.
//

import Foundation
import SharedModels

public struct RegionalWeatherFeatureState: Equatable {
    var isRegionalDaysRequestInFlight: Bool
    var days: [RegionalDay]
    var regionalDaysRequestError: ApiError?

    init(
        days: [RegionalDay],
        isRegionalDaysRequestInFlight: Bool,
        regionalDaysRequestError: ApiError? = nil
    ) {
        self.isRegionalDaysRequestInFlight = isRegionalDaysRequestInFlight
        self.days = days
        self.regionalDaysRequestError = regionalDaysRequestError
    }
}

extension RegionalWeatherFeatureState {

    public static var initialState: Self {
        .init(
            days: [],
            isRegionalDaysRequestInFlight: false,
            regionalDaysRequestError: nil
        )
    }
}

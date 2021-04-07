//
//  CountriesState.swift
//  
//
//  Created by Roberto Casula on 07/04/21.
//

import Foundation
import SharedModels

public struct CountriesState: Equatable {

    var countries: [Country]
    var isCountriesRequestInFlight: Bool
    var countriesRequestError: ApiError?

    public init(
        countries: [Country],
        isCountriesRequestInFlight: Bool,
        countriesRequestError: ApiError? = nil
    ) {
        self.countries = countries
        self.isCountriesRequestInFlight = isCountriesRequestInFlight
        self.countriesRequestError = countriesRequestError
    }
}

extension CountriesState {

    public static var initialState: Self {
        .init(
            countries: [],
            isCountriesRequestInFlight: false,
            countriesRequestError: nil
        )
    }
}

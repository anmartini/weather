//
//  CountriesState.swift
//
//
//  Created by Roberto Casula on 07/04/21.
//

import CountryFeature
import Foundation
import SharedModels

public struct CountriesState: Equatable {

    var countries: [Country]
    var isCountriesRequestInFlight: Bool
    var countriesRequestError: ApiError?

    var selection: CountryState?

    public init(
        countries: [Country],
        isCountriesRequestInFlight: Bool,
        countriesRequestError: ApiError? = nil,
        selection: CountryState? = nil
    ) {
        self.countries = countries
        self.isCountriesRequestInFlight = isCountriesRequestInFlight
        self.countriesRequestError = countriesRequestError
        self.selection = selection
    }
}

extension CountriesState {

    public static var initialState: Self {
        .init(
            countries: [],
            isCountriesRequestInFlight: false,
            countriesRequestError: nil,
            selection: nil
        )
    }
}

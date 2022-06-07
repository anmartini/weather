//
//  State.swift
//
//
//  Created by Roberto Casula on 07/04/21.
//

import Foundation
import SharedModels

public struct CountryState: Equatable {

    public let country: Country
    var countryDays: [CountryDay]

    var isCountryDaysRequestInFlight: Bool
    var countryDaysRequestError: ApiError?

    public init(
        country: Country,
        countryDays: [CountryDay] = [],
        isCountryDaysRequestInFlight: Bool = false,
        countryDaysRequestError: ApiError? = nil
    ) {
        self.country = country
        self.countryDays = countryDays
        self.isCountryDaysRequestInFlight = isCountryDaysRequestInFlight
        self.countryDaysRequestError = countryDaysRequestError
    }
}

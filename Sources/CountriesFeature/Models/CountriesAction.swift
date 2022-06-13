//
//  CountriesAction.swift
//
//
//  Created by Roberto Casula on 07/04/21.
//

import ComposableArchitecture
import CountryFeature
import Foundation
import SharedModels

public enum CountriesAction: Equatable {

    case onAppear
    case loadCountries
    case countriesResponse(TaskResult<[Country]>)

    case setNavigation(selection: Country?)
    case country(CountryAction)
}

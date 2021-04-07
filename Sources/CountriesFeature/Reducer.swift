//
//  Reducer.swift
//  
//
//  Created by Roberto Casula on 07/04/21.
//

import Foundation
import CountryFeature
import ComposableArchitecture

public let countriesReducer = Reducer<CountriesState, CountriesAction, CountriesEnvironment>
    .combine(
        countryReducer
            .optional()
            .pullback(
                state: \CountriesState.selection,
                action: /CountriesAction.country,
                environment: {
                    CountryEnvironment(
                        countryDays: $0.countryDays,
                        mainQueue: $0.mainQueue
                    )
                }
            ),
        .init { state, action, environment in
            switch action {
            case .onAppear:
                if state.countries.isEmpty {
                    return .init(value: .loadCountries)
                }
                return .none
            case .loadCountries:
                state.isCountriesRequestInFlight = true
                state.countriesRequestError = nil
                return environment.countries()
                    .catchToEffect()
                    .map(CountriesAction.countriesResponse)
                    .delay(for: 1, scheduler: environment.mainQueue.eraseToAnyScheduler())
                    .eraseToEffect()
            case .countriesResponse(.success(let countries)):
                state.isCountriesRequestInFlight = false
                state.countriesRequestError = nil
                state.countries = countries
                return .none
            case .countriesResponse(.failure(let error)):
                state.isCountriesRequestInFlight = false
                state.countriesRequestError = error
                return .none
            case .setNavigation(selection: .some(let country)):
                state.selection = .init(country: country)
                return .none
            case .setNavigation(selection: .none):
                state.selection = nil
                return .none
            case .country(_):
                return .none
            }
        }
    )
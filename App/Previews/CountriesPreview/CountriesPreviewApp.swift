//
//  CountriesPreviewApp.swift
//  CountriesPreview
//
//  Created by Roberto Casula on 07/04/21.
//

import ApiClientLive
import ComposableArchitecture
import CountriesFeature
import SharedModels
import SwiftUI

@main
struct CountriesPreviewApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                CountriesView(
                    store: .init(
                        initialState: .initialState,
                        reducer: countriesReducer,
                        environment: CountriesEnvironment(
                            countries: loadCountries,
                            countryDays: loadCountryDays(country:days:)
                        )
                    )
                )
                .navigationTitle("Countries")
            }
        }
    }
}

func loadCountries() -> Effect<[Country], ApiError> {
    return ApiClient.live().countries()
}

func loadCountryDays(country: Country, days: [String]) -> Effect<[CountryDay], ApiError> {
    return ApiClient.live().countryDays(days, country)
}

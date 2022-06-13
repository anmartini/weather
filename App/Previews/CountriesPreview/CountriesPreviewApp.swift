//
//  CountriesPreviewApp.swift
//  CountriesPreview
//
//  Created by Roberto Casula on 07/04/21.
//

import ApiClient
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
                        environment: {
                            var apiClient: ApiClient = .noop
                            apiClient.override(
                                routeCase: /ServerRoute.Api.Route.countries,
                                withResponse: { _ in
                                    try await Task.sleep(nanoseconds: 3_000_000_000)
                                    return ok(
                                        [
                                            Country(
                                                code: "PR",
                                                name: "Parma"
                                            ),
                                            Country(
                                                code: "RE",
                                                name: "Reggio Emilia"
                                            ),
                                            Country(
                                                code: "BO",
                                                name: "Bologna"
                                            ),
                                            Country(
                                                code: "FE",
                                                name: "Ferrara"
                                            ),
                                        ]
                                    )
                                }
                            )
                            apiClient.override(
                                routeCase: /ServerRoute.Api.Route.countryDay(day:countryCode:),
                                withResponse: { _ in
                                    try await Task.sleep(nanoseconds: 2_000_000_000)
                                    return ok(
                                        CountryDay(
                                            day: .init(),
                                            forecast: "asdasd",
                                            updatedAt: .init(),
                                            zones: [
                                                .init(
                                                    code: "--", name: "--", forecast: nil, times: []
                                                )
                                            ]
                                        )
                                    )
                                }
                            )
                            return .init(
                                apiClient: apiClient,
                                mainQueue: .immediate
                            )
                        }()
                    )
                )
                .navigationTitle("Countries")
            }
        }
    }
}

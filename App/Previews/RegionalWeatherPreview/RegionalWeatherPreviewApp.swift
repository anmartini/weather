//
//  RegionalWeatherPreviewApp.swift
//  RegionalWeatherPreview
//
//  Created by Roberto Casula on 04/04/21.
//

import ApiClient
import ApiClientLive
import ComposableArchitecture
import RegionalWeatherFeature
import SharedModels
import SwiftUI

@main
struct RegionalWeatherPreviewApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                RegionalWeatherView(
                    store: .init(
                        initialState: .initialState,
                        reducer: regionalWeatherFeatureReducer,
                        environment: {
                            var apiClient: ApiClient = .noop
                            apiClient.override(
                                routeCase: /ServerRoute.Api.Route.regionalDay(day:),
                                withResponse: { _ in
                                    try await Task.sleep(nanoseconds: 2_000_000_000)
                                    return ok(
                                        RegionalDay(
                                            day: Date(),
                                            forecast: RegionalForecast(
                                                weather:
                                                    "cielo sereno o poco nuvoloso. Formazione di banchi di nebbia nella notte a cominciare dalla costa e dal ferrarese.",
                                                temperature:
                                                    "massime prossime a 20 gradi; valori tra 15 e 17 gradi lungo la costa.",
                                                wind:
                                                    "deboli e variabili con deboli brezze dal mare lungo la costa.",
                                                sea: "calmo."
                                            ),
                                            updatedAt: Date()
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
                .navigationTitle("Regional days")
            }
        }
    }
}

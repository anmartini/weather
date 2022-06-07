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
                        environment: .init(
                            regionalDays: loadRegionalDays(_:)
                        )
                    )
                )
                .navigationTitle("Regional days")
            }
        }
    }
}

func loadRegionalDays(_ days: [String]) -> Effect<[RegionalDay], ApiError> {
    return ApiClient.live().regionalDays(["1", "2", "3"])
}

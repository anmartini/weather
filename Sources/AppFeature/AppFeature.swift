//
//  AppFeature.swift
//  
//
//  Created by Roberto Casula on 08/04/21.
//

import ApiClient
import Foundation
import SharedModels
import CountriesFeature
import RegionalWeatherFeature
import ComposableArchitecture

public struct AppState: Equatable {
    public var regional: RegionalWeatherState
    public var countries: CountriesState

    public init(
        regional: RegionalWeatherState = .initialState,
        countries: CountriesState = .initialState
    ) {
        self.regional = regional
        self.countries = countries
    }
}

public enum AppAction: Equatable {
    case regional(RegionalWeatherAction)
    case countries(CountriesAction)
}

public struct AppEnvironment {
    public var apiClient: ApiClient
    public var mainQueue: AnySchedulerOf<DispatchQueue>

    public init(
        apiClient: ApiClient,
        mainQueue: AnySchedulerOf<DispatchQueue> = DispatchQueue.main.eraseToAnyScheduler()
    ) {
        self.apiClient = apiClient
        self.mainQueue = mainQueue
    }
}

extension AppEnvironment {
    var regionalWeather: RegionalWeatherEnvironment {
        .init(
            regionalDays: apiClient.regionalDays,
            mainQueue: mainQueue
        )
    }

    var countries: CountriesEnvironment {
        .init(
            countries: apiClient.countries,
            countryDays: apiClient.countryDays,
            mainQueue: mainQueue
        )
    }

    public static let noop = Self(
        apiClient: .noop,
        mainQueue: DispatchQueue.main.eraseToAnyScheduler()
    )
}


public let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    regionalWeatherFeatureReducer
        .pullback(
            state: \.regional,
            action: /AppAction.regional,
            environment: { $0.regionalWeather }
        ),
    countriesReducer
        .pullback(
            state: \.countries,
            action: /AppAction.countries,
            environment: { $0.countries }
        )
)

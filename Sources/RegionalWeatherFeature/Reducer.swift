//
//  Reducer.swift
//  
//
//  Created by Roberto Casula on 03/04/21.
//

import Foundation
import ComposableArchitecture

public let regionalWeatherFeatureReducer = Reducer<
    RegionalWeatherState,
    RegionalWeatherAction,
    RegionalWeatherEnvironment
> { state, action, environment in
    switch action {
    case .onAppear:
        if state.days.isEmpty {
            return .init(value: .loadWeather(days: ["1", "2", "3"]))
        }
        return .none
    case .loadWeather(let days):
        state.isRegionalDaysRequestInFlight = true
        state.regionalDaysRequestError = nil
        return environment.regionalDays(days)
            .catchToEffect()
            .map(RegionalWeatherAction.regionalDaysResponse)
            .delay(for: 1, scheduler: environment.mainQueue.eraseToAnyScheduler())
            .eraseToEffect()
    case .regionalDaysResponse(.success(let days)):
        state.isRegionalDaysRequestInFlight = false
        state.regionalDaysRequestError = nil
        state.days = days
        return .none
    case .regionalDaysResponse(.failure(let error)):
        state.isRegionalDaysRequestInFlight = false
        state.regionalDaysRequestError = error
        return .none
    }
}

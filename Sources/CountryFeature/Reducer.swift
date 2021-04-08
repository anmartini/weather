//
//  Reducer.swift
//  
//
//  Created by Roberto Casula on 07/04/21.
//

import Foundation
import ComposableArchitecture

public let countryReducer = Reducer<
    CountryState, CountryAction, CountryEnvironment
> { state, action, environment in
    switch action {
    case .view(.onAppear):
        if state.countryDays.isEmpty {
            return .init(value: .loadDays)
        }
        return .none
    case .loadDays:
        state.countryDaysRequestError = nil
        state.isCountryDaysRequestInFlight = true
        return environment.countryDays(state.country, ["1", "2", "3"])
            .catchToEffect()
            .map(CountryAction.daysResponse)
            .delay(for: 1, scheduler: environment.mainQueue.eraseToAnyScheduler())
            .eraseToEffect()
    case .daysResponse(.success(let days)):
        state.isCountryDaysRequestInFlight = false
        state.countryDays = days
        return .none
    case .daysResponse(.failure(let error)):
        state.isCountryDaysRequestInFlight = false
        state.countryDaysRequestError = error
        return .none
    }
}
//.debug()

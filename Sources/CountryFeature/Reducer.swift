//
//  Reducer.swift
//
//
//  Created by Roberto Casula on 07/04/21.
//

import ApiClient
import ComposableArchitecture
import SharedModels

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

        let countryCode = state.country.code
        let days = ["1", "2", "3"]
        return Effect.task {
            await TaskResult {
                try await withThrowingTaskGroup(of: CountryDay.self, returning: [CountryDay].self) {
                    group in
                    for day in days {
                        group.addTask(priority: .background) {
                            try await environment.apiClient
                                .apiRequest(
                                    route: .countryDay(countryCode: countryCode, day: day),
                                    as: CountryDay.self
                                )
                        }
                    }

                    return try await group.reduce(
                        into: [CountryDay](),
                        { result, countryDay in
                            result.append(countryDay)
                        })
                }
            }
        }
        .map(CountryAction.daysResponse)
    case .daysResponse(.success(let days)):
        state.isCountryDaysRequestInFlight = false
        state.countryDays = days
        return .none
    case .daysResponse(.failure(let error)):
        state.isCountryDaysRequestInFlight = false
        state.countryDaysRequestError = .init(error: error)
        return .none
    }
}

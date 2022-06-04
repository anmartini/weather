//
//  RegionalWeatherEnvironment.swift
//
//
//  Created by Roberto Casula on 03/04/21.
//

import ApiClient
import ComposableArchitecture
import Foundation
import SharedModels

public struct RegionalWeatherEnvironment {
    public var apiClient: ApiClient
    public var mainQueue: AnySchedulerOf<DispatchQueue>

    public init(
        apiClient: ApiClient,
        mainQueue: AnySchedulerOf<DispatchQueue> = DispatchQueue.main.eraseToAnyScheduler()
    ) {
        self.apiClient = apiClient
        self.mainQueue = mainQueue
    }

    public static let noop = Self(
        apiClient: .noop,
        mainQueue: DispatchQueue.main.eraseToAnyScheduler()
    )
}

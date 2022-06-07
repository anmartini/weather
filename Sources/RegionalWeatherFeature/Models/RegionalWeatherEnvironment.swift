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
    public var regionalDays: ([String]) -> Effect<[RegionalDay], ApiError>
    public var mainQueue: AnySchedulerOf<DispatchQueue>

    public init(
        regionalDays: @escaping ([String]) -> Effect<[RegionalDay], ApiError>,
        mainQueue: AnySchedulerOf<DispatchQueue> = DispatchQueue.main.eraseToAnyScheduler()
    ) {
        self.regionalDays = regionalDays
        self.mainQueue = mainQueue
    }

    public static let noop = Self(
        regionalDays: { _ in .none },
        mainQueue: DispatchQueue.main.eraseToAnyScheduler()
    )
}

//
//  Environment.swift
//
//
//  Created by Roberto Casula on 07/04/21.
//

import ComposableArchitecture
import Foundation
import SharedModels

public struct CountryEnvironment {
    public var countryDays: (Country, [String]) -> Effect<[CountryDay], ApiError>
    public var mainQueue: AnySchedulerOf<DispatchQueue>

    public init(
        countryDays: @escaping (Country, [String]) -> Effect<[CountryDay], ApiError>,
        mainQueue: AnySchedulerOf<DispatchQueue> = DispatchQueue.main.eraseToAnyScheduler()
    ) {
        self.countryDays = countryDays
        self.mainQueue = mainQueue
    }

    public static let noop = Self(
        countryDays: { _, _ in .none },
        mainQueue: DispatchQueue.main.eraseToAnyScheduler()
    )
}

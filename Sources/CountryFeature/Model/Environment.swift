//
//  Environment.swift
//  
//
//  Created by Roberto Casula on 07/04/21.
//

import Foundation
import SharedModels
import ComposableArchitecture

public struct CountryEnvironment {
    public var countryDays:
        (Country, [String]) -> Effect<[CountryDay], ApiError>
    public var mainQueue: AnySchedulerOf<DispatchQueue>

    public init(
        countryDays: @escaping (Country, [String]) -> Effect<[CountryDay], ApiError>,
        mainQueue: AnySchedulerOf<DispatchQueue> = DispatchQueue.main.eraseToAnyScheduler()
    ) {
        self.countryDays = countryDays
        self.mainQueue = mainQueue
    }
}

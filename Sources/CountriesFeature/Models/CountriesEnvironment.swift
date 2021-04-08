//
//  CountriesEnvironment.swift
//  
//
//  Created by Roberto Casula on 07/04/21.
//

import Foundation
import SharedModels
import ComposableArchitecture

public struct CountriesEnvironment {

    public var countries: () -> Effect<[Country], ApiError>
    public var countryDays:
        (Country, [String]) -> Effect<[CountryDay], ApiError>
    public var mainQueue: AnySchedulerOf<DispatchQueue>

    public init(
        countries: @escaping () -> Effect<[Country], ApiError>,
        countryDays: @escaping (Country, [String]) -> Effect<[CountryDay], ApiError>,
        mainQueue: AnySchedulerOf<DispatchQueue> = DispatchQueue.main.eraseToAnyScheduler()
    ) {
        self.countries = countries
        self.countryDays = countryDays
        self.mainQueue = mainQueue
    }

    public static let noop = Self(
        countries: { .none },
        countryDays: { _,_ in .none },
        mainQueue: DispatchQueue.main.eraseToAnyScheduler()
    )
}

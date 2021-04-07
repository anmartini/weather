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
    public var mainQueue: AnySchedulerOf<DispatchQueue>

    public init(
        countries: @escaping () -> Effect<[Country], ApiError>,
        mainQueue: AnySchedulerOf<DispatchQueue> = DispatchQueue.main.eraseToAnyScheduler()
    ) {
        self.countries = countries
        self.mainQueue = mainQueue
    }
}

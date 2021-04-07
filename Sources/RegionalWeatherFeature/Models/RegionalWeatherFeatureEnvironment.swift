//
//  RegionalWeatherFeatureEnvironment.swift
//  
//
//  Created by Roberto Casula on 03/04/21.
//

import ApiClient
import Foundation
import SharedModels
import ComposableArchitecture

public struct RegionalWeatherFeatureEnvironment {
    public var regionalDays:
        ([String]) -> Effect<[RegionalDay], ApiError>
    public var mainQueue: AnySchedulerOf<DispatchQueue>

    public init(
        regionalDays: @escaping ([String]) -> Effect<[RegionalDay], ApiError>,
        mainQueue: AnySchedulerOf<DispatchQueue> = DispatchQueue.main.eraseToAnyScheduler()
    ) {
        self.regionalDays = regionalDays
        self.mainQueue = mainQueue
    }
}

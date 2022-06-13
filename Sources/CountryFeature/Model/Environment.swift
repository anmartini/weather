//
//  Environment.swift
//
//
//  Created by Roberto Casula on 07/04/21.
//

import ApiClient
import Foundation
import SharedModels
import ComposableArchitecture

public struct CountryEnvironment {
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

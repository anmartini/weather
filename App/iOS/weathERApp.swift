//
//  weathERApp.swift
//  weathER
//
//  Created by Andrea Martini on 25/02/21.
//

import ApiClientLive
import AppFeature
import ComposableArchitecture
import SwiftUI

@main
struct weathERApp: App {

    let store = Store(
        initialState: .init(),
        reducer: appReducer,
        environment: .live
    )

    var body: some Scene {
        WindowGroup {
            AppView(store: store)
        }
    }
}

extension AppEnvironment {
    static var live: Self {
        .init(
            apiClient: .live(),
            mainQueue: DispatchQueue.main.eraseToAnyScheduler()
        )
    }
}

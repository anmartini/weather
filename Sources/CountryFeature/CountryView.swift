//
//  CountryView.swift
//  
//
//  Created by Roberto Casula on 07/04/21.
//

import SwiftUI
import SharedModels
import ComposableArchitecture

public struct CountryView: View {

    let store: Store<CountryState, CountryAction>

    public var body: some View {
        WithViewStore(
            self.store.scope(state: { $0 }, action: CountryAction.view)
        ) { viewStore in
            List {
                ForEach(viewStore.countryDays) { countryDay in
                    CountryDayView(countryDay: countryDay)
                }
            }
            .navigationTitle(viewStore.country.name)
            .overlay(
                viewStore.isCountryDaysRequestInFlight ? ProgressView() : nil
            )
            .onAppear() {
                viewStore.send(.onAppear)
            }
        }
    }

    public init(store: Store<CountryState, CountryAction>) {
        self.store = store
    }
}

extension CountryView {

    public enum Action: Equatable {
        case onAppear
    }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(
            store: .init(
                initialState: .init(
                    country: .init(code: "FE", name: "Ferrara"),
                    countryDays: [
                        .init(
                            day: .init(),
                            forecast: "asdasd",
                            updatedAt: .init(),
                            zones: []
                        )
                    ],
                    isCountryDaysRequestInFlight: false
                ),
                reducer: countryReducer,
                environment: .init(
                    countryDays: { _, _ in .none }
                )
            )
        )
    }
}


//
//  CountriesView.swift
//  
//
//  Created by Roberto Casula on 07/04/21.
//

import SwiftUI
import SharedModels
import CountryFeature
import ComposableArchitecture

public struct CountriesView: View {

    let store: Store<CountriesState, CountriesAction>

    public var body: some View {
        WithViewStore(self.store) { viewStore in
            List {
                ForEach(viewStore.countries) { country in
                    NavigationLink(
                        destination: IfLetStore(
                            self.store.scope(
                                state: { $0.selection },
                                action: CountriesAction.country
                            ),
                            then: CountryView.init(store:),
                            else: ProgressView()
                        ),
                        tag: country,
                        selection: viewStore.binding(
                            get: { $0.selection?.country },
                            send: CountriesAction.setNavigation(selection:)
                        )
                    ) {
                        Text(country.name)
                    }
                }
            }
            .overlay(
                viewStore.isCountriesRequestInFlight ?
                    ProgressView() : nil
            )
            .onAppear() {
                viewStore.send(.onAppear)
            }
        }
    }

    public init(store: Store<CountriesState, CountriesAction>) {
        self.store = store
    }
}

struct CountriesView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesView(
            store: .init(
                initialState: .init(
                    countries: [
                        Country(
                            code: "PR",
                            name: "Parma"
                        ),
                        Country(
                            code: "RE",
                            name: "Reggio Emilia"
                        ),
                        Country(
                            code: "BO",
                            name: "Bologna"
                        ),
                        Country(
                            code: "FE",
                            name: "Ferrara"
                        )
                    ],
                    isCountriesRequestInFlight: false
                ),
                reducer: countriesReducer,
                environment: .init(
                    countries: { .none },
                    countryDays: { _, _ in .none }
                )
            )
        )
    }
}

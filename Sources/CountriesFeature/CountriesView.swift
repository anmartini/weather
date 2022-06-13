//
//  CountriesView.swift
//
//
//  Created by Roberto Casula on 07/04/21.
//

import ApiClient
import ComposableArchitecture
import CountryFeature
import SharedModels
import SwiftUI

public struct CountriesView: View {

    let store: Store<CountriesState, CountriesAction>

    public var body: some View {
        WithViewStore(self.store) { viewStore in
            List {
                if viewStore.isCountriesRequestInFlight {
                    ForEach(0..<2) { _ in
                        Text("Coutry Name Placeholder")
                            .redacted(reason: .placeholder)
                            .shimmering()
                    }
                }

                ForEach(viewStore.countries) { country in
                    NavigationLink(
                        destination: IfLetStore(
                            self.store.scope(
                                state: \.selection,
                                action: CountriesAction.country
                            ),
                            then: CountryView.init(store:),
                            else: ProgressView.init
                        ),
                        tag: country,
                        selection: viewStore.binding(
                            get: \.selection?.country,
                            send: CountriesAction.setNavigation(selection:)
                        )
                    ) {
                        Text(country.name)
                    }
                }
            }
            .onAppear {
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
        Group {
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
                            ),
                        ],
                        isCountriesRequestInFlight: false
                    ),
                    reducer: countriesReducer,
                    environment: .noop
                )
            )

            CountriesView(
                store: .init(
                    initialState: .init(
                        countries: [],
                        isCountriesRequestInFlight: true
                    ),
                    reducer: countriesReducer,
                    environment: {
                        var apiClient: ApiClient = .noop
                        apiClient.override(
                            routeCase: /ServerRoute.Api.Route.countries,
                            withResponse: { _ in
                                try await Task.sleep(nanoseconds: 3_000_000_000)
                                return ok(
                                    [
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
                                        ),
                                    ]
                                )
                            }
                        )
                        return .init(
                            apiClient: apiClient,
                            mainQueue: .immediate
                        )
                    }()
                )
            )

            CountriesView(
                store: .init(
                    initialState: .init(
                        countries: [],
                        isCountriesRequestInFlight: true
                    ),
                    reducer: countriesReducer,
                    environment: .noop
                )
            )
        }
    }
}

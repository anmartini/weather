//
//  CountryView.swift
//
//
//  Created by Roberto Casula on 07/04/21.
//

import ComposableArchitecture
import ApiClient
import SharedViews

public struct CountryView: View {

    let store: Store<CountryState, CountryAction>

    public var body: some View {
        WithViewStore(
            self.store.scope(state: { $0 }, action: CountryAction.view)
        ) { viewStore in
            List {
                if viewStore.isCountryDaysRequestInFlight {
                    ForEach(0..<2) { _ in
                        CountryDayView(countryDay: .placeholder)
                        .redacted(reason: .placeholder)
                        .shimmering()
                    }
                }

                ForEach(viewStore.countryDays) { countryDay in
                    CountryDayView(countryDay: countryDay)
                }
            }
            .navigationTitle(viewStore.country.name)
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
        Group {
            CountryView(
                store: .init(
                    initialState: .init(
                        country: .init(code: "FE", name: "Ferrara"),
                        countryDays: [
                            .init(
                                day: .init(),
                                forecast: "asdasd",
                                updatedAt: .init(),
                                zones: [
                                    .init(
                                        code: "P",
                                        name: "pianura e capoluogo",
                                        forecast: .init(
                                            rain: "rain", // nil
                                            wind: 32,
                                            temperature: .init(
                                                min: 15,
                                                max: 27
                                            )
                                        ),
                                        times: [
                                            .init(
                                                weather: .init(
                                                    value: "a003a003",
                                                    text: .init(
                                                        it: "sereno o poco nuvoloso",
                                                        en: "partly cloudy"
                                                    )
                                                )
                                            )
                                        ]
                                    )
//                                    .init(
//                                        code: "P",
//                                        name: "pianura e capoluogo",
//                                        forecast: .init(
//                                            rain: "rain", // nil
//                                            wind: 32,
//                                            temperature: .init(
//                                                min: 15,
//                                                max: 27
//                                            )
//                                        ),
//                                        times: [
//                                            .init(
//                                                weather: .init(
//                                                    value: "a003a003",
//                                                    text: .init(
//                                                        it: "sereno o poco nuvoloso",
//                                                        en: "partly cloudy"
//                                                    )
//                                                )
//                                            ),
//                                            .init(
//                                                weather: .init(
//                                                    value: "a003a003",
//                                                    text: .init(
//                                                        it: "sereno o poco nuvoloso",
//                                                        en: "partly cloudy"
//                                                    )
//                                                )
//                                            ),
//                                            .init(
//                                                weather: .init(
//                                                    value: "b005b016",
//                                                    text: .init(
//                                                        it: "tendenza ad attenuazione della nuvolosità",
//                                                        en: "decreasing cloudiness tendency"
//                                                    )
//                                                )
//                                            )
//                                        ]
//                                    )
                                ]
                            ),
                            .init(
                                day: .init(),
                                forecast: "asdasd",
                                updatedAt: .init(),
                                zones: [
//                                    .init(
//                                        code: "P",
//                                        name: "pianura e capoluogo",
//                                        forecast: .init(
//                                            rain: "rain", // nil
//                                            wind: 32,
//                                            temperature: .init(
//                                                min: 15,
//                                                max: 27
//                                            )
//                                        ),
//                                        times: [
//                                            .init(
//                                                weather: .init(
//                                                    value: "a003a003",
//                                                    text: .init(
//                                                        it: "sereno o poco nuvoloso",
//                                                        en: "partly cloudy"
//                                                    )
//                                                )
//                                            ),
//                                            .init(
//                                                weather: .init(
//                                                    value: "a003a003",
//                                                    text: .init(
//                                                        it: "sereno o poco nuvoloso",
//                                                        en: "partly cloudy"
//                                                    )
//                                                )
//                                            ),
//                                            .init(
//                                                weather: .init(
//                                                    value: "b005b016",
//                                                    text: .init(
//                                                        it: "tendenza ad attenuazione della nuvolosità",
//                                                        en: "decreasing cloudiness tendency"
//                                                    )
//                                                )
//                                            )
//                                        ]
//                                    )
                                ]
                            )
                        ],
                        isCountryDaysRequestInFlight: false
                    ),
                    reducer: countryReducer,
                    environment: .noop
                )
            )

            CountryView(
                store: .init(
                    initialState: .init(
                        country: .init(code: "FE", name: "Ferrara"),
                        countryDays: [],
                        isCountryDaysRequestInFlight: true
                    ),
                    reducer: countryReducer,
                    environment: {
                        var apiClient: ApiClient = .noop
                        apiClient.override(
                            routeCase: /ServerRoute.Api.Route.countryDay(countryCode:day:),
                            withResponse: { _ in
                                try await Task.sleep(nanoseconds: 2000000000)
                                return ok(
                                    CountryDay(
                                        day: .init(),
                                        forecast: "asdasd",
                                        updatedAt: .init(),
                                        zones: [
                                            .init(code: "--", name: "--", forecast: nil, times: [])
                                        ]
                                    )
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

            CountryView(
                store: .init(
                    initialState: .init(
                        country: .init(code: "FE", name: "Ferrara"),
                        countryDays: [],
                        isCountryDaysRequestInFlight: true
                    ),
                    reducer: countryReducer,
                    environment: .noop
                )
            )
        }
    }
}

extension CountryDay {

    static var placeholder: Self {
        .init(
            day: .init(),
            forecast: "",
            updatedAt: .init(),
            zones: [
                .init(code: "--", name: "--", forecast: nil, times: [])
            ]
        )
    }
}

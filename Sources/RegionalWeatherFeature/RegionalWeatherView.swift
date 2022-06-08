//
//  RegionalWeatherView.swift
//
//
//  Created by Roberto Casula on 03/04/21.
//

import ComposableArchitecture
import ApiClient
import SharedViews

public struct RegionalWeatherView: View {

    let store: Store<RegionalWeatherState, RegionalWeatherAction>

    public var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                List {
                    if viewStore.isRegionalDaysRequestInFlight {
                        ForEach(0..<2) { _ in
                            RegionalWeatherCellView(
                                regionalDay: .placeholder
                            )
                            .redacted(reason: .placeholder)
                            .shimmering()
                        }
                    }

                    ForEach(viewStore.days) { regionalDay in
                        RegionalWeatherCellView(regionalDay: regionalDay)
                    }
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }

    public init(store: Store<RegionalWeatherState, RegionalWeatherAction>) {
        self.store = store
    }
}

struct RegionalWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RegionalWeatherView(
                store: .init(
                    initialState: .init(
                        days: [
                            RegionalDay(
                                day: Date(),
                                forecast: RegionalForecast(
                                    weather: "cielo sereno o poco nuvoloso. Formazione di banchi di nebbia nella notte a cominciare dalla costa e dal ferrarese.",
                                    temperature: "massime prossime a 20 gradi; valori tra 15 e 17 gradi lungo la costa.",
                                    wind: "deboli e variabili con deboli brezze dal mare lungo la costa.",
                                    sea: "calmo."
                                ),
                                updatedAt: Date()
                            ),
                            RegionalDay(
                                day: Date(),
                                forecast: RegionalForecast(
                                    weather: "cielo sereno o poco nuvoloso. Formazione di banchi di nebbia nella notte a cominciare dalla costa e dal ferrarese.",
                                    temperature: "massime prossime a 20 gradi; valori tra 15 e 17 gradi lungo la costa.",
                                    wind: "deboli e variabili con deboli brezze dal mare lungo la costa.",
                                    sea: "calmo."
                                ),
                                updatedAt: Date()
                            )
                        ],
                        isRegionalDaysRequestInFlight: false,
                        regionalDaysRequestError: nil
                    ),
                    reducer: regionalWeatherFeatureReducer,
                    environment: .noop
                )
            )

            RegionalWeatherView(
                store: .init(
                    initialState: .init(
                        days: [],
                        isRegionalDaysRequestInFlight: true,
                        regionalDaysRequestError: nil
                    ),
                    reducer: regionalWeatherFeatureReducer,
                    environment: {
                        var apiClient: ApiClient = .noop
                        apiClient.override(
                            routeCase: /ServerRoute.Api.Route.regionalDay(day:),
                            withResponse: { _ in
                                try await Task.sleep(nanoseconds: 2000000000)
                                return ok(
                                    RegionalDay(
                                        day: Date(),
                                        forecast: RegionalForecast(
                                            weather: "cielo sereno o poco nuvoloso. Formazione di banchi di nebbia nella notte a cominciare dalla costa e dal ferrarese.",
                                            temperature: "massime prossime a 20 gradi; valori tra 15 e 17 gradi lungo la costa.",
                                            wind: "deboli e variabili con deboli brezze dal mare lungo la costa.",
                                            sea: "calmo."
                                        ),
                                        updatedAt: Date()
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

            RegionalWeatherView(
                store: .init(
                    initialState: .init(
                        days: [],
                        isRegionalDaysRequestInFlight: true,
                        regionalDaysRequestError: nil
                    ),
                    reducer: regionalWeatherFeatureReducer,
                    environment: .noop
                )
            )
        }
    }
}

extension RegionalDay {

    static var placeholder: Self {
        .init(
            day: .init(),
            forecast: .init(weather: "", temperature: "", wind: "", sea: ""),
            updatedAt: .init()
        )
    }
}

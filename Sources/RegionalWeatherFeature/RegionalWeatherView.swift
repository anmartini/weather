//
//  RegionalWeatherView.swift
//  
//
//  Created by Roberto Casula on 03/04/21.
//

import SwiftUI
import SharedModels
import ComposableArchitecture

public struct RegionalWeatherView: View {

    let store: Store<RegionalWeatherFeatureState, RegionalWeatherFeatureAction>

    public var body: some View {
        WithViewStore(self.store) { viewStore in
            if viewStore.isRegionalDaysRequestInFlight {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .green))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(AnyTransition.opacity.animation(Animation.default.delay(1.5)))
            } else {
                List {
                    ForEach(viewStore.days) { regionalDay in
                        RegionalWeatherCellView(regionalDay: regionalDay)
                    }
                }
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        }
    }

    public init(
        store: Store<RegionalWeatherFeatureState,
                     RegionalWeatherFeatureAction>
    ) {
        self.store = store
    }
}

struct RegionalWeatherView_Previews: PreviewProvider {
    static var previews: some View {
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
                environment: .init(
                    regionalDays: loadRegionalDays(days:),
                    mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
            )
        )
    }

    static func loadRegionalDays(days: [String]) -> Effect<[RegionalDay], ApiError> {
        return .none
    }
}

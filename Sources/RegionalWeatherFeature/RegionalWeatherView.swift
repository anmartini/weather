//
//  RegionalWeatherView.swift
//
//
//  Created by Roberto Casula on 03/04/21.
//

import ComposableArchitecture
import SharedModels
import SwiftUI

public struct RegionalWeatherView: View {

    let store: Store<RegionalWeatherState, RegionalWeatherAction>

    public var body: some View {
        WithViewStore(self.store) { viewStore in
            List {
                ForEach(viewStore.days) { regionalDay in
                    RegionalWeatherCellView(regionalDay: regionalDay)
                }
            }
            .overlay(
                viewStore.isRegionalDaysRequestInFlight
                    ? ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .green))
                    //                    .transition(AnyTransition.opacity.animation(Animation.default.delay(1.5)))
                    : nil
            )
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
        RegionalWeatherView(
            store: .init(
                initialState: .init(
                    days: [
                        RegionalDay(
                            day: Date(),
                            forecast: RegionalForecast(
                                weather:
                                    "cielo sereno o poco nuvoloso. Formazione di banchi di nebbia nella notte a cominciare dalla costa e dal ferrarese.",
                                temperature:
                                    "massime prossime a 20 gradi; valori tra 15 e 17 gradi lungo la costa.",
                                wind:
                                    "deboli e variabili con deboli brezze dal mare lungo la costa.",
                                sea: "calmo."
                            ),
                            updatedAt: Date()
                        ),
                        RegionalDay(
                            day: Date(),
                            forecast: RegionalForecast(
                                weather:
                                    "cielo sereno o poco nuvoloso. Formazione di banchi di nebbia nella notte a cominciare dalla costa e dal ferrarese.",
                                temperature:
                                    "massime prossime a 20 gradi; valori tra 15 e 17 gradi lungo la costa.",
                                wind:
                                    "deboli e variabili con deboli brezze dal mare lungo la costa.",
                                sea: "calmo."
                            ),
                            updatedAt: Date()
                        ),
                    ],
                    isRegionalDaysRequestInFlight: false,
                    regionalDaysRequestError: nil
                ),
                reducer: regionalWeatherFeatureReducer,
                environment: .noop
            )
        )
    }
}

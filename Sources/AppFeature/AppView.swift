//
//  AppView.swift
//  
//
//  Created by Roberto Casula on 29/03/21.
//

import SwiftUI
import CountriesFeature
import RegionalWeatherFeature
import ComposableArchitecture

public struct AppView: View {

    let store: Store<AppState, AppAction>

    public var body: some View {
        TabView() {
            NavigationView {
                RegionalWeatherView(
                    store: self.store.scope(
                        state: \.regional,
                        action: AppAction.regional
                    )
                )
                .navigationTitle("Regione")
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Regione", systemImage: "map.fill")
            }
            .accentColor(.white)

            NavigationView {
                CountriesView(
                    store: self.store.scope(
                        state: \.countries,
                        action: AppAction.countries
                    )
                )
                .navigationTitle("Province")
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Province", systemImage: "mappin.circle.fill")
            }
            .accentColor(.white)
        }
    }

    public init(store: Store<AppState, AppAction>) {
        self.store = store
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(
            store: .init(
                initialState: .init(),
                reducer: appReducer,
                environment: .noop
            )
        )
    }
}

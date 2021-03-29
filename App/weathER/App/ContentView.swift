//
//  ContentView.swift
//  weathER
//
//  Created by Andrea Martini on 25/02/21.
//

import SwiftUI
import Combine
import Alamofire

struct ContentView: View {
        
    var body: some View {
        TabView() {
            NavigationView {
                RegionalView()
                    .navigationTitle("Regione")
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Regione", systemImage: "map.fill")
            }.accentColor(.white)
            
            NavigationView {
                CountriesView()
                    .navigationTitle("Province")
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Province", systemImage: "mappin.circle.fill")
            }.accentColor(.white)
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

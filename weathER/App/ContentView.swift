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
        NavigationView {
            WeatherView()
                .navigationTitle("Meteo Arpae")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

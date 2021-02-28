//
//  WeatherView.swift
//  weathER
//
//  Created by Roberto Casula on 28/02/21.
//

import SwiftUI

struct WeatherView: View {
    
    @ObservedObject var viewModel = WeatherViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.regionalDays, id: \.self) { regionalDay in
                RegionalDayView(regionalDay: regionalDay)
                    .padding(.vertical)
            }
        }
        .onAppear() {
            self.loadData()
        }
    }
    
    private func loadData() {
        viewModel.loadData()
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

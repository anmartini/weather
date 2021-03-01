//
//  CountryView.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import SwiftUI

struct CountryView: View {
    
    let country: Country
    
    @ObservedObject var viewModel = CountryViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.countryDays, id: \.self) { countryDay in
                CountryDayView(countryDay: countryDay)
            }
        }
        .onAppear() {
            self.loadData()
        }
        .navigationTitle(country.name)
    }
    
    private func loadData() {
        viewModel.loadData(country: country)
    }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(country: Country(code: "BO", name: "Bologna"))
    }
}

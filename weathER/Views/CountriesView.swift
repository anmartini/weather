//
//  CountriesView.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import SwiftUI

struct CountriesView: View {
    
    @ObservedObject var viewModel = CountriesViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.countries, id: \.self) { country in
                NavigationLink(destination: CountryView(country: country)) {
                    Text(country.name)
                }
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

struct CountriesView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesView()
    }
}

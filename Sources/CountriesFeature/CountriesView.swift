//
//  CountriesView.swift
//  
//
//  Created by Roberto Casula on 07/04/21.
//

import SwiftUI

struct CountriesView: View {

    var body: some View {
        List {
//            ForEach(viewModel.countries, id: \.self) { country in
//                NavigationLink(destination: CountryView(country: country)) {
//                    Text(country.name)
//                }
//            }
        }
        .onAppear() {
            
        }
    }
}

struct CountriesView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesView()
    }
}

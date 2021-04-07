//
//  CountryViewModel.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Combine
import Foundation
import SharedModels
import ApiClientLive

class CountryViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()
    
    @Published public var countryDays = [CountryDay]()
    let client = ApiClient.live()
    
    init() {
    }
    
    func loadData(country: Country) {
        self.client.countryDays(["1", "2", "3"], country)
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .sink { value in
                self.countryDays = value.sorted(by: { $0.day.compare($1.day) == .orderedAscending })
            }
            .store(in: &cancellables)
    }
}

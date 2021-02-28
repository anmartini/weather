//
//  CountryViewModel.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Combine
import Foundation

class CountryViewModel: ObservableObject {
    
    private let weatherService: WeatherService
    private var cancellables = Set<AnyCancellable>()
    
    @Published public var countryDays = [CountryDay]()
    
    
    init() {
        self.weatherService = .init()
    }
    
    func loadData() {
        self.weatherService.getCountryDays()
            .receive(on: RunLoop.main)
            .sink { value in
                self.countryDays = value.sorted(by: { $0.day.compare($1.day) == .orderedAscending })
            }
            .store(in: &cancellables)
    }
}

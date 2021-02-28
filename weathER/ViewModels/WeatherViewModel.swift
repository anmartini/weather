//
//  WeatherViewModel.swift
//  weathER
//
//  Created by Roberto Casula on 28/02/21.
//

import Combine
import Foundation

class WeatherViewModel: ObservableObject {
    
    private let weatherService: WeatherService
    private var cancellables = Set<AnyCancellable>()
    
    @Published public var regionalDays = [RegionalDay]()
    
    
    init() {
        self.weatherService = .init()
    }
    
    func loadData() {
        self.weatherService.getWeatherData()
            .receive(on: RunLoop.main)
            .sink { value in
                self.regionalDays = value.sorted(by: { $0.day.compare($1.day) == .orderedAscending })
            }
            .store(in: &cancellables)
    }
}

//
//  CountriesViewModel.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Combine
import Foundation
import Networking
import SharedModels

class CountriesViewModel: ObservableObject {
    
    private let countriesService: CountriesService
    private var cancellables = Set<AnyCancellable>()
    
    @Published public var countries = [Country]()
    
    
    init() {
        self.countriesService = .init()
    }
    
    func loadData() {
        self.countriesService.getCountries()
            .receive(on: RunLoop.main)
            .sink { value in
                self.countries = value
            }
            .store(in: &cancellables)
    }
}

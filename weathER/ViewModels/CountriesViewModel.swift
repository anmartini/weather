//
//  CountriesViewModel.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Combine
import Foundation

class CountriesViewModel: ObservableObject {
    
    private let utilsService: UtilsService
    private var cancellables = Set<AnyCancellable>()
    
    @Published public var countries = [Country]()
    
    
    init() {
        self.utilsService = .init()
    }
    
    func loadData() {
        self.utilsService.getCountries()
            .receive(on: RunLoop.main)
            .sink { value in
                self.countries = value
            }
            .store(in: &cancellables)
    }
}

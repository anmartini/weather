//
//  CountriesViewModel.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Combine
import Foundation
import SharedModels
import ApiClientLive

class CountriesViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()
    
    @Published public var countries = [Country]()

    let client = ApiClient.live()
    
    init() {
    }
    
    func loadData() {
        self.client.countries()
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .sink { value in
                self.countries = value
            }
            .store(in: &cancellables)
    }
}

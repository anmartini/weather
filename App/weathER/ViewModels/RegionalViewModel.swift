//
//  RegionalViewModel.swift
//  weathER
//
//  Created by Roberto Casula on 28/02/21.
//

import Combine
import Foundation
import SharedModels
import ApiClientLive

class RegionalViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()
    
    @Published public var regionalDays = [RegionalDay]()

    let client = ApiClient.live()
    
    
    init() {
    }
    
    func loadData() {
        self.client.regionalDays(["1", "2", "3"])
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .sink { value in
                self.regionalDays = value.sorted(by: { $0.day.compare($1.day) == .orderedAscending })
            }
            .store(in: &cancellables)
    }
}

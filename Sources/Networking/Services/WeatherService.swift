//
//  WeatherService.swift
//  weathER
//
//  Created by Roberto Casula on 28/02/21.
//

import Combine
import Foundation
import SharedModels

public class WeatherService {
    
    public init() {}
    
    public func getRegionalDays() -> AnyPublisher<[RegionalDay], Never> {
        let days = ["1", "2", "3"]
        let publishers: [AnyPublisher<RegionalDay, Never>] = days.map {
            RegionalDailyRequest
                .request(for: $0)
                .compactMap { result in
                    switch result {
                    case .success(let value):
                        return value
                    case .failure(_):
                        return nil
                    }
                }
                .eraseToAnyPublisher()
        }
        return Publishers.MergeMany(publishers)
            .collect()
            .eraseToAnyPublisher()
    }
    
    public func getCountryDays(country: Country) -> AnyPublisher<[CountryDay], Never> {
        let days = ["1", "2", "3"]
        let publishers: [AnyPublisher<CountryDay, Never>] = days.map {
            CountryDailyRequest
                .request(for: $0, country: country.code)
                .compactMap { result in
                    switch result {
                    case .success(let value):
                        return value
                    case .failure(_):
                        return nil
                    }
                }
                .eraseToAnyPublisher()
        }
        return Publishers.MergeMany(publishers)
            .collect()
            .eraseToAnyPublisher()
    }
}

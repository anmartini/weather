//
//  WeatherService.swift
//  weathER
//
//  Created by Roberto Casula on 28/02/21.
//

import Combine
import Foundation

public class WeatherService {
        
    func getRegionalDays() -> AnyPublisher<[RegionalDay], Never> {
        let weather1 = RegionalDailyRequest.requestFuture(for: "1")
                            .catch { _ in Empty<RegionalDay, Never>() }
        let weather2 = RegionalDailyRequest.requestFuture(for: "2")
                            .catch { _ in Empty<RegionalDay, Never>() }
        let weather3 = RegionalDailyRequest.requestFuture(for: "3")
                            .catch { _ in Empty<RegionalDay, Never>() }
        
        return Publishers.MergeMany([weather1, weather2, weather3])
                         .collect()
                         .eraseToAnyPublisher()
    }
    
    func getCountryDays() -> AnyPublisher<[CountryDay], Never> {
        let weather1 = CountryDailyRequest.requestFuture(for: "1", country: "BO")
                            .catch { _ in Empty<CountryDay, Never>() }
        let weather2 = CountryDailyRequest.requestFuture(for: "2", country: "BO")
                            .catch { _ in Empty<CountryDay, Never>() }
        let weather3 = CountryDailyRequest.requestFuture(for: "3", country: "BO")
                            .catch { _ in Empty<CountryDay, Never>() }
        
        return Publishers.MergeMany([weather1, weather2, weather3])
                         .collect()
                         .eraseToAnyPublisher()
    }
}

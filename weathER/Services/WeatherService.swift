//
//  WeatherService.swift
//  weathER
//
//  Created by Roberto Casula on 28/02/21.
//

import Combine
import Foundation

public class WeatherService {
        
    func getWeatherData() -> AnyPublisher<[RegionalDay], Never> {
        let weather1 = DailyWeatherRequest.requestFuture(for: "1")
                            .catch { _ in Empty<RegionalDay, Never>() }
        let weather2 = DailyWeatherRequest.requestFuture(for: "2")
                            .catch { _ in Empty<RegionalDay, Never>() }
        let weather3 = DailyWeatherRequest.requestFuture(for: "3")
                            .catch { _ in Empty<RegionalDay, Never>() }
        
        return Publishers.MergeMany([weather1, weather2, weather3])
                         .collect()
                         .eraseToAnyPublisher()
    }
}

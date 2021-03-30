//
//  CountriesService.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Combine
import Foundation
import SharedModels

public class CountriesService {
    
    public init() {}
    
    public func getCountries() -> AnyPublisher<[Country], Never> {
        return CountriesRequest.request().map { result in
            switch result {
            case .success(let countries):
                return countries
            case .failure(_):
                return []
            }
        }
        .eraseToAnyPublisher()
    }
}

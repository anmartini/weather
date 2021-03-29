//
//  UtilsService.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Combine
import Foundation

public class UtilsService {
    
    func getCountries() -> AnyPublisher<[Country], Never> {
        return CountriesRequest.requestFuture()
            .catch { _ in Empty<[Country], Never>() }
            .eraseToAnyPublisher()
    }
}

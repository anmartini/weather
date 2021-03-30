//
//  CountriesRequest.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Combine
import Alamofire
import Foundation
import SharedModels

struct CountriesRequest {
    
    static let path: String = "/daily/countries"

    static func request() -> AnyPublisher<Result<[Country], AFError>, Never> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return BaseRequest.request(
            path,
            of: [Country].self,
            decoder: decoder
        )
    }
}

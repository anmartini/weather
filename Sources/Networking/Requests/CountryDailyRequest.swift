//
//  CountryDailyRequest.swift
//  weathER
//
//  Created by Andrea Martini on 28/02/21.
//

import Combine
import Alamofire
import Foundation
import SharedModels

struct CountryDailyRequest {
    
    static let path: String = "/daily/countries/{country}/days/{day}"

    static func request(
        for day: String,
        country: String
    ) -> AnyPublisher<Result<CountryDay, AFError>, Never> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let url = path.replacingOccurrences(of: "{day}", with: day)
            .replacingOccurrences(of: "{country}", with: country)
        return BaseRequest.request(
            url,
            of: CountryDay.self,
            decoder: decoder
        )
    }
}


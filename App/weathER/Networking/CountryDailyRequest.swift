//
//  CountryDailyRequest.swift
//  weathER
//
//  Created by Andrea Martini on 28/02/21.
//

import Combine
import Alamofire
import Foundation

struct CountryDailyRequest {
    
    static let path: String = "/daily/countries/{country}/days/{day}"
    
    static func request(for day: String, country: String, completion: @escaping (DataResponse<CountryDay, AFError>) -> Void) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        BaseRequest.request(path.replacingOccurrences(of: "{day}", with: day).replacingOccurrences(of: "{country}", with: country),
                            decoder: decoder,
                            completion: completion)
    }
    
    static func requestFuture(for day: String, country: String) -> Future<CountryDay, Error>{
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return BaseRequest.requestFuture(path.replacingOccurrences(of: "{day}", with: day).replacingOccurrences(of: "{country}", with: country),
                                         of: CountryDay.self,
                                         decoder: decoder)
    }
}


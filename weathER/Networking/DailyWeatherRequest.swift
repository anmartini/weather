//
//  DailyWeatherRequest.swift
//  weathER
//
//  Created by Roberto Casula on 28/02/21.
//

import Alamofire
import Foundation

struct DailyWeatherRequest {
    
    static let path: String = "/daily/region/days/{day}"
    
    static func request(for day: String, completion: @escaping (DataResponse<RegionalDay, AFError>) -> Void) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        BaseRequest.request(path.replacingOccurrences(of: "{day}", with: day),
                            decoder: decoder,
                            completion: completion)
    }
}

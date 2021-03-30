//
//  RegionalDailyRequest.swift
//  weathER
//
//  Created by Roberto Casula on 28/02/21.
//

import Combine
import Alamofire
import Foundation
import SharedModels

struct RegionalDailyRequest {
    
    static let path: String = "/daily/region/days/{day}"

    static func request(
        for day: String
    ) -> AnyPublisher<Result<RegionalDay, AFError>, Never> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return BaseRequest.request(
            path.replacingOccurrences(of: "{day}", with: day),
            of: RegionalDay.self,
            decoder: decoder
        )
    }
}

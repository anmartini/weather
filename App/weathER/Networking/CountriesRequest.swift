//
//  CountriesRequest.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Combine
import Alamofire
import Foundation

struct CountriesRequest {
    
    static let path: String = "/daily/countries"
    
    static func request(completion: @escaping (DataResponse<[Country], AFError>) -> Void) {
        BaseRequest.request(path, completion: completion)
    }
    
    static func requestFuture() -> Future<[Country], Error>{
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return BaseRequest.requestFuture(path,
                                         of: [Country].self,
                                         decoder: decoder)
    }
}

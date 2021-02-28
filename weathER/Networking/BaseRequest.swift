//
//  BaseRequest.swift
//  weathER
//
//  Created by Roberto Casula on 28/02/21.
//

import Alamofire
import Foundation

public struct BaseRequest {
    
    static var baseUrl: String { Environment.current.baseUrl }
    
    public static func request<T: Decodable>(_ path: String,
                                             of type: T.Type = T.self,
                                             decoder: DataDecoder = JSONDecoder(),
                                             queue: DispatchQueue = .main,
                                             completion: @escaping (DataResponse<T, AFError>) -> Void) {
        var path = path
        if !path.hasPrefix("/") {
            path = "/\(path)"
        }
        let url = "\(baseUrl)\(path)"
        AF.request(url).responseDecodable(of: type, queue: queue, decoder: decoder, completionHandler: completion)
    }
}

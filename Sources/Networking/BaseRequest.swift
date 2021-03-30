//
//  BaseRequest.swift
//  weathER
//
//  Created by Roberto Casula on 28/02/21.
//

import Combine
import Alamofire
import Foundation

public struct BaseRequest {
    
    static var baseUrl: String { Environment.current.baseUrl }

    public static func request<T: Decodable>(
        _ path: String,
        of type: T.Type = T.self,
        decoder: DataDecoder = JSONDecoder(),
        queue: DispatchQueue = .main
    ) -> AnyPublisher<Result<T, AFError>, Never> {
        return request(path)
            .publishDecodable(
                type: type,
                queue: queue,
                decoder: decoder
            )
            .map(\.result)
            .eraseToAnyPublisher()
    }
    
    static func request<T: Decodable>(
        _ path: String,
        of type: T.Type = T.self,
        decoder: DataDecoder = JSONDecoder(),
        queue: DispatchQueue = .main,
        completion: @escaping (DataResponse<T, AFError>) -> Void
    ) {
        request(path)
            .responseDecodable(
                of: type,
                queue: queue,
                decoder: decoder,
                completionHandler: completion
            )
    }
    
    private static func request(_ path: String) -> DataRequest {
        var path = path
        if !path.hasPrefix("/") {
            path = "/\(path)"
        }
        let url = "\(baseUrl)\(path)"
        return AF.request(url)
    }
}

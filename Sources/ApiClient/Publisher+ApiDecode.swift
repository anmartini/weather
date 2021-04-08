//
//  Publisher+ApiDecode.swift
//  
//
//  Created by Roberto Casula on 02/04/21.
//

import Combine
import Alamofire
import SharedModels
import ComposableArchitecture

extension Publisher where Output == Data, Failure == AFError {
    public func apiDecode<A: Decodable>(
        as type: A.Type,
        decoder: JSONDecoder = JSONDecoder(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> Effect<A, ApiError> {
        self
            .mapError { ApiError(error: $0, file: file, line: line) }
            .flatMap { data -> AnyPublisher<A, ApiError> in
                do {
                    return try Just(decoder.decode(A.self, from: data))
                        .setFailureType(to: ApiError.self)
                        .eraseToAnyPublisher()
                } catch let decodingError {
                    do {
                        return try Fail(
                            error: decoder.decode(ApiError.self, from: data)
                        ).eraseToAnyPublisher()
                    } catch {
                        return Fail(error: ApiError(error: decodingError)).eraseToAnyPublisher()
                    }
                }
            }
            .eraseToEffect()
    }
}

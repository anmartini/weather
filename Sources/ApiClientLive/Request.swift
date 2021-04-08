//
//  Request.swift
//  
//
//  Created by Roberto Casula on 03/04/21.
//

import Router
import Routes
import Combine
import Alamofire
import Foundation
import ComposableArchitecture

func request(
    baseUrl: URL,
    route: Route,
    router: Router<Route>
) -> Effect<(data: Data, response: HTTPURLResponse?), AFError> {
    let request = router.request(route, baseUrl)
    return AF.request(request.url, method: request.method)
        .publishData()
        .extractError()
        .eraseToEffect()
}

public func apiRequest(
    baseUrl: URL,
    route: Route.Api.Route,
    router: Router<Route>
) -> Effect<(data: Data, response: HTTPURLResponse?), AFError> {
    return request(
        baseUrl: baseUrl,
        route: .api(.init(route: route)),
        router: router
    )
}

extension Publisher where Output == DataResponsePublisher<Data>.Output,
                          Failure == Never {

    func extractError() -> AnyPublisher<
        (data: Data, response: HTTPURLResponse?), AFError
    > {
        return self
            .flatMap { response
                -> AnyPublisher<(data: Data, response: HTTPURLResponse?), AFError> in
                switch response.result {
                case .success(let data):
                    return Just((data: data, response: response.response))
                        .setFailureType(to: AFError.self)
                        .eraseToAnyPublisher()
                case .failure(let error):
                    return Fail(error: error)
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}

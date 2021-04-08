//
//  Client.swift
//  
//
//  Created by Roberto Casula on 02/04/21.
//

import Routes
import Alamofire
import Foundation
import SharedModels
import ComposableArchitecture

public struct ApiClient {

    public var baseUrl: () -> URL
    public var jsonDecoder: () -> JSONDecoder
    public var request:
        (Route) -> Effect<(data: Data, response: HTTPURLResponse?), AFError>
    public var apiRequest:
        (Route.Api.Route) -> Effect<(data: Data, response: HTTPURLResponse?), AFError>
    public var countries:
        () -> Effect<[Country], ApiError>
    public var regionalDays:
        ([String]) -> Effect<[RegionalDay], ApiError>
    public var countryDays:
        (Country, [String]) -> Effect<[CountryDay], ApiError>

    public init(
        baseUrl: @escaping () -> URL,
        jsonDecoder: @escaping () -> JSONDecoder,
        request: @escaping (Route) -> Effect<
            (data: Data, response: HTTPURLResponse?), AFError
        >,
        apiRequest: @escaping (Route.Api.Route) -> Effect<
            (data: Data, response: HTTPURLResponse?), AFError
        >,
        countries: @escaping () -> Effect<[Country], ApiError>,
        regionalDays: @escaping ([String]) -> Effect<[RegionalDay], ApiError>,
        countryDays: @escaping (Country, [String]) -> Effect<[CountryDay], ApiError>
    ) {
        self.baseUrl = baseUrl
        self.jsonDecoder = jsonDecoder
        self.request = request
        self.apiRequest = apiRequest
        self.countries = countries
        self.regionalDays = regionalDays
        self.countryDays = countryDays
    }
}

extension ApiClient {
    public static let noop = Self(
        baseUrl: { URL(string: "/")! },
        jsonDecoder: { JSONDecoder() },
        request: { _ in .none },
        apiRequest: { _ in .none },
        countries: { .none },
        regionalDays: { _ in .none },
        countryDays: { _, _ in .none }
    )
}

//extension ApiClient {
//
//    public func apiRequest<A: Decodable>(
//        route: Route.Api.Route,
//        as: A.Type,
//        file: StaticString = #file,
//        line: UInt = #line
//    ) -> Effect<A, ApiError> {
//        self.apiRequest(route)
//            .handleEvents(
//                receiveOutput: {
//                    #if DEBUG
//                    debugPrint(
//                        """
//                        API: route: \(route), \
//                        status: \($0.response?.statusCode ?? 0), \
//                        receive data: \(String(decoding: $0.data, as: UTF8.self))
//                        """
//                    )
//                    #endif
//                }
//            )
//            .map(\.data)
//            .apiDecode(as: A.self, file: file, line: line)
//            .print("API")
//            .eraseToEffect()
//    }
//
//    public func request<A: Decodable>(
//        route: Route,
//        as: A.Type,
//        file: StaticString = #file,
//        line: UInt = #line
//    ) -> Effect<A, ApiError> {
//        self.request(route)
//            .handleEvents(
//                receiveOutput: {
//                    #if DEBUG
//                    debugPrint(
//                        """
//                        API: route: \(route), \
//                        status: \($0.response?.statusCode ?? 0), \
//                        receive data: \(String(decoding: $0.data, as: UTF8.self))
//                        """
//                    )
//                    #endif
//                }
//            )
//            .map(\.data)
//            .apiDecode(as: A.self, file: file, line: line)
//            .print("API")
//            .eraseToEffect()
//    }
//}
//
//let jsonDecoder = JSONDecoder()

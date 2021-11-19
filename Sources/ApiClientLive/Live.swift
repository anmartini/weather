//
//  Live.swift
//  
//
//  Created by Roberto Casula on 03/04/21.
//

import Router
import Routes
import Combine
import Foundation
import SharedModels
@_exported import ApiClient
import ComposableArchitecture

extension ApiClient {

    public static func live(
        baseUrl defaultBaseUrl: URL = URL(string: "https://meteo.kyntos.it")!
    ) -> Self {
        let baseUrl = defaultBaseUrl
        let router = Router<Route>.shared
        let decoder = ApiClientLive.jsonDecoder
        return Self(
            baseUrl: { baseUrl },
            jsonDecoder: { decoder },
            request: { route in
                return ApiClientLive.request(
                    baseUrl: baseUrl,
                    route: route,
                    router: router
                )
            },
            apiRequest: { route in
                return ApiClientLive.apiRequest(
                    baseUrl: baseUrl,
                    route: route,
                    router: router
                )
            },
            countries: {
                return ApiClientLive.apiRequest(
                    baseUrl: baseUrl,
                    route: .countries,
                    router: router
                )
                .map(\.data)
                .apiDecode(as: [Country].self, decoder: decoder)
                .eraseToEffect()
            },
            regionalDays: { days in
                let requests = days.map {
                    ApiClientLive.apiRequest(
                        baseUrl: baseUrl,
                        route: .regionalDay(day: $0),
                        router: router
                    )
                    .map(\.data)
                    .apiDecode(as: RegionalDay.self, decoder: decoder)
                }
                return Publishers.MergeMany(requests)
                    .collect()
                    .eraseToEffect()
            },
            countryDays: { country, days in
                let requests = days.map {
                    ApiClientLive.apiRequest(
                        baseUrl: baseUrl,
                        route: .countryDay(day: $0, country: country),
                        router: router
                    )
                    .map(\.data)
                    .apiDecode(as: CountryDay.self, decoder: decoder)
                }
                return Publishers.MergeMany(requests)
                    .collect()
                    .eraseToEffect()
            }
        )
    }
}

private let jsonDecoder = { () -> JSONDecoder in
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
}()

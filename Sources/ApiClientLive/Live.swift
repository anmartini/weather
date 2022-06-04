//
//  Live.swift
//  
//
//  Created by Roberto Casula on 03/04/21.
//

import ApiClient
import Foundation
import ServerRouter
import SharedModels
import URLRouting

extension ApiClient {

    public static func live(
        baseUrl defaultBaseUrl: URL = URL(string: "https://meteo.kyntos.it")!
    ) -> Self {
        var baseUrl: URL = defaultBaseUrl

        let router = ServerRouter(
            date: Date.init,
            decoder: decoder,
            encoder: encoder
        )

        return Self(
            request: { route in
                try await ApiClientLive.request(
                    baseUrl: baseUrl,
                    route: route,
                    router: router
                )
            },
            apiRequest: { route in
                try await ApiClientLive.apiRequest(
                    baseUrl: baseUrl,
                    route: route,
                    router: router
                )
            },
            baseUrl: { baseUrl },
            setBaseUrl: { @MainActor url in
                baseUrl = url
            }
        )
    }
}

private func request(
    baseUrl: URL,
    route: ServerRoute,
    router: ServerRouter
) async throws -> (value: Data, response: URLResponse) {
    let client = URLRoutingClient.live(
        router: router.baseURL(baseUrl.absoluteString)
    )
    return try await client.data(for: route)
}

private func apiRequest(
    baseUrl: URL,
    route: ServerRoute.Api.Route,
    router: ServerRouter
) async throws -> (value: Data, response: URLResponse) {
    return try await request(
        baseUrl: baseUrl,
        route: .api(
            .init(route: route)
        ),
        router: router
    )
}

private let encoder = { () -> JSONEncoder in
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    return encoder
}()

private let decoder = { () -> JSONDecoder in
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
}()

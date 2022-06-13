//
//  Client.swift
//  
//
//  Created by Roberto Casula on 02/04/21.
//

import Foundation
import SharedModels

public struct ApiClient {

    public var request: (ServerRoute) async throws -> (value: Data, response: URLResponse)
    public var apiRequest: (ServerRoute.Api.Route) async throws -> (value: Data, response: URLResponse)
    public var baseUrl: () -> URL
    public var setBaseUrl: (URL) async -> Void

    public init(
        request: @escaping (ServerRoute) async throws -> (value: Data, response: URLResponse),
        apiRequest: @escaping (ServerRoute.Api.Route) async throws -> (value: Data, response: URLResponse),
        baseUrl: @escaping () -> URL,
        setBaseUrl: @escaping (URL) async -> Void
    ) {
        self.request = request
        self.apiRequest = apiRequest
        self.baseUrl = baseUrl
        self.setBaseUrl = setBaseUrl
    }

    public struct Unit: Codable {}

    public func apiRequest(
        route: ServerRoute.Api.Route,
        file: StaticString = #file,
        line: UInt = #line
    ) async throws {
        _ = try await self.apiRequest(route: route, as: Unit.self, file: file, line: line)
    }

    public func apiRequest<A: Decodable>(
        route: ServerRoute.Api.Route,
        as: A.Type,
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> A {
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await self.apiRequest(route)
        } catch {
            throw ApiError(error: error)
        }
#if DEBUG
        print(
        """
          API: route: \(route), \
          status: \((response as? HTTPURLResponse)?.statusCode ?? 0), \
          receive data: \(String(decoding: data, as: UTF8.self))
        """
        )
#endif
        let value: A
        do {
            value = try decoder.decode(A.self, from: data)
        } catch let decodingError {
            do {
                throw try decoder.decode(ApiError.self, from: data)
            } catch {
                throw ApiError(error: decodingError)
            }
        }

        return value
    }

    public func request<A: Decodable>(
        route: ServerRoute,
        as: A.Type,
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> A {
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await self.request(route)
        } catch {
            throw ApiError(error: error)
        }
#if DEBUG
        print(
        """
          API: route: \(route), \
          status: \((response as? HTTPURLResponse)?.statusCode ?? 0), \
          receive data: \(String(decoding: data, as: UTF8.self))
        """
        )
#endif
        let value: A
        do {
            value = try decoder.decode(A.self, from: data)
        } catch let decodingError {
            do {
                throw try decoder.decode(ApiError.self, from: data)
            } catch {
                throw ApiError(error: decodingError)
            }
        }

        return value
    }
}

#if DEBUG
import XCTestDebugSupport
import XCTestDynamicOverlay
import CasePaths

extension ApiClient {
    struct Unimplemented: Error {}
    public static let failing = Self(
        request: { route in
            XCTFail("\(Self.self).request(\(route)) is unimplemented")
            throw Unimplemented()
        },
        apiRequest: { route in
            XCTFail("\(Self.self).apiRequest(\(route)) is unimplemented")
            throw Unimplemented()
        },

        baseUrl: {
            XCTFail("\(Self.self).baseUrl is unimplemented")
            return .init(string: "/")!
        },
        setBaseUrl: { _ in
            XCTFail("ApiClient.setBaseUrl is unimplemented")
        }
    )

    public mutating func override(
        route matchingRoute: ServerRoute.Api.Route,
        withResponse response: @escaping () async throws -> (value: Data, response: URLResponse)
    ) {
        let fulfill = expectation(description: "route")
        self.apiRequest = { [self] route in
            if route == matchingRoute {
                fulfill()
                return try await response()
            } else {
                return try await self.apiRequest(route)
            }
        }
    }

    public mutating func override<Value>(
        routeCase matchingRoute: CasePath<ServerRoute.Api.Route, Value>,
        withResponse response: @escaping (Value) async throws -> (value: Data, response: URLResponse)
    ) {
        let fulfill = expectation(description: "route")
        self.apiRequest = { [self] route in
            if let value = matchingRoute.extract(from: route) {
                fulfill()
                return try await response(value)
            } else {
                return try await self.apiRequest(route)
            }
        }
    }
}
#endif

extension ApiClient {
    public static let noop = Self(
        request: { _ in
            (Data(), URLResponse())
        },
        apiRequest: { _ in
            (Data(), URLResponse())
        },
        baseUrl: { URL(string: "/")! },
        setBaseUrl: { _ in }
    )
}

public let encoder = { () -> JSONEncoder in
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    return encoder
}()

public let decoder = { () -> JSONDecoder in
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
}()

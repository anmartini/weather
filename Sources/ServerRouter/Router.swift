//
//  ServerRouter.swift
//
//
//  Created by Roberto Casula on 03/04/21.
//

import Foundation
import Parsing
import SharedModels
import URLRouting
import XCTestDynamicOverlay
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public struct ServerRouter: ParserPrinter {
    let date: () -> Date
    let decoder: JSONDecoder
    let encoder: JSONEncoder

    var body: AnyParserPrinter<URLRequestData, ServerRoute> {
        OneOf {
            Route(.case(ServerRoute.api)) {
                Path { "api" }
                Headers {
                    Field("accept") {
                        "application/json"
                    }
                }
                Parse(.memberwise(ServerRoute.Api.init(route:))) {
                    self.apiRouter
                }
            }
        }
        .eraseToAnyParserPrinter()
    }

    @ParserBuilder
    var apiRouter: AnyParserPrinter<URLRequestData, ServerRoute.Api.Route> {
        OneOf {
            Route(.case(ServerRoute.Api.Route.countries)) {
                Path { "daily"; "countries" }
            }

            Route(.case(ServerRoute.Api.Route.regionalDay(day:))) {
                Path {
                    "daily"
                    "region"
                    "days"
                    Parse(.string)
                }
            }

            Route(.case(ServerRoute.Api.Route.countryDay(day:countryCode:))) {
                Path {
                    "daily"
                    "countries"
                    Parse(.string)
                    "days"
                    Parse(.string)
                }
            }
        }
        .eraseToAnyParserPrinter()
    }

    public init(
        date: @escaping () -> Date,
        decoder: JSONDecoder,
        encoder: JSONEncoder
    ) {
        self.date = date
        self.decoder = decoder
        self.encoder = encoder
    }

    public func parse(_ input: inout URLRequestData) throws -> ServerRoute {
        try self.body.parse(&input)
    }

    public func print(_ output: ServerRoute, into input: inout URLRequestData) throws {
        try self.body.print(output, into: &input)
    }
}

#if DEBUG
extension ServerRouter {
    public static let test = Self(
        date: { Date(timeIntervalSince1970: 1_234_567_890) },
        decoder: jsonDecoder,
        encoder: jsonEncoder
    )

    public static let failing = Self(
        date: {
            XCTFail("\(Self.self).date is unimplemented")
            return .init()
        },
        decoder: jsonDecoder,
        encoder: jsonEncoder
    )
}

private let jsonEncoder = { () -> JSONEncoder in
    let encoder = JSONEncoder()
    encoder.outputFormatting = .sortedKeys
    encoder.dateEncodingStrategy = .secondsSince1970
    return encoder
}()

private let jsonDecoder = { () -> JSONDecoder in
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    return decoder
}()
#endif

extension Body {
    init() where Bytes == Parsers.ReplaceError<Rest<Bytes.Input>> {
        self.init { Rest<Bytes.Input>().replaceError(with: .init()) }
    }
}


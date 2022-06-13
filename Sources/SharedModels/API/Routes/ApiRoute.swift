//
//  ApiRoute.swift
//
//
//  Created by Roberto Casula on 02/04/21.
//

import Foundation

extension ServerRoute {

    public struct Api: Equatable {
        public let route: Route

        public init(
            route: Route
        ) {
            self.route = route
        }

        public enum Route: Equatable {
            case countries
            case regionalDay(day: String)
            case countryDay(countryCode: String, day: String)
        }
    }
}

//
//  Router.swift
//
//
//  Created by Roberto Casula on 03/04/21.
//

import Alamofire
import Foundation
import Routes
import SharedModels

public struct Router<GenericRoute> {

    public let request: (GenericRoute, URL) -> (url: URLConvertible, method: HTTPMethod)

    public init(
        _ request: @escaping (GenericRoute, URL)
            -> (url: URLConvertible, method: HTTPMethod)
    ) {
        self.request = request
    }

    private func callAsFunction(
        _ route: GenericRoute,
        _ base: URL
    ) -> (url: URLConvertible, method: HTTPMethod) {
        self.request(route, base)
    }
}

extension Router where GenericRoute == Route {

    public static let shared: Router<Route> = Router<Route> { route, base in
        switch route {
        case .api(let apiRoute):
            return apiRequest(apiRoute.route, base)
        }
    }
}

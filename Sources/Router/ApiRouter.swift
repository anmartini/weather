//
//  ApiRouter.swift
//  
//
//  Created by Roberto Casula on 03/04/21.
//

import Routes
import Alamofire
import Foundation
import SharedModels

let apiRequest = Router<Route.Api.Route> { route, base in
    let baseUrl = base.appendingPathComponent("api")
    switch route {
    case .countries:
        let path = "daily/countries"
        let url = baseUrl.appendingPathComponent(path)
        return (url: url, method: .get)
    case .regionalDay(day: let day):
        let path = "daily/region/days/{day}"
            .replacingOccurrences(of: "{day}", with: day)
        let url = baseUrl.appendingPathComponent(path)
        return (url: url, method: .get)
    case .countryDay(day: let day, country: let country):
        let path = "daily/countries/{country}/days/{day}"
            .replacingOccurrences(of: "{day}", with: day)
            .replacingOccurrences(of: "{country}", with: country.code)
        let url = baseUrl.appendingPathComponent(path)
        return (url: url, method: .get)
    }
}

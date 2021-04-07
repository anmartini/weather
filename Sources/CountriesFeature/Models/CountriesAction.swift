//
//  CountriesAction.swift
//  
//
//  Created by Roberto Casula on 07/04/21.
//

import Foundation
import SharedModels

public enum CountriesAction: Equatable {

    case onAppear
    case loadCountries
    case countriesResponse(Result<[Country], ApiError>)
}

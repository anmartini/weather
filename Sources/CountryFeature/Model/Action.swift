//
//  Action.swift
//
//
//  Created by Roberto Casula on 07/04/21.
//

import Foundation
import SharedModels
import ComposableArchitecture

public enum CountryAction: Equatable {
    case view(CountryView.Action)
    case loadDays
    case daysResponse(TaskResult<[CountryDay]>)
}

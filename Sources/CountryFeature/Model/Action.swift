//
//  Action.swift
//
//
//  Created by Roberto Casula on 07/04/21.
//

import ComposableArchitecture
import Foundation
import SharedModels

public enum CountryAction: Equatable {
    case view(CountryView.Action)
    case loadDays
    case daysResponse(TaskResult<[CountryDay]>)
}

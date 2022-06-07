//
//  String+CapitalizedFirstLetter.swift
//
//  Created by Andrea Martini on 28/02/21.
//

import Foundation

extension String {

    public var capitalizedFirstLetter: String {
        prefix(1).uppercased() + lowercased().dropFirst()
    }
}

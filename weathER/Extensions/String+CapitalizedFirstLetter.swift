//
//  String+CapitalizedFirstLetter.swift
//  weathER
//
//  Created by Andrea Martini on 28/02/21.
//

import Foundation

extension String {
    func capitalizedFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizedFirstLetter()
    }
}

//
//  String+HTMLStripped.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import Foundation

extension String {
    func htmlStripped() -> String {
        return self.replacingOccurrences(
            of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }

    mutating func htmlStrip() {
        self = self.htmlStripped()
    }
}

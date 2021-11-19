//
//  UINavigationController+Colors.swift
//  weathER
//
//  Created by Roberto Casula on 28/02/21.
//

import UIKit
import Foundation

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()

        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = .systemGreen
        standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        let compactAppearance = UINavigationBarAppearance()
        compactAppearance.backgroundColor = .systemGreen
        compactAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.backgroundColor = .systemGreen
        scrollEdgeAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        scrollEdgeAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationBar.standardAppearance = standardAppearance
        navigationBar.compactAppearance = compactAppearance
        navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
    }
}

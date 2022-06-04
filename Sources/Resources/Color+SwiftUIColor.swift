//
//  File.swift
//
//
//  Created by Roberto Casula on 20/04/21.
//

import Foundation
import SwiftUI

#if os(macOS)
    import AppKit
#elseif os(iOS)
    import UIKit
#elseif os(tvOS) || os(watchOS)
    import UIKit
#endif

extension ColorAsset.Color {

    public var color: Color { .init(self) }
}

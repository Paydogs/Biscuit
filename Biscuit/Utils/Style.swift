//
//  Style.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 15..
//

import Foundation
import AppKit
import SwiftUI

struct Style {
    static func attributes(color: Color,
                           font: NSFont = NSFont.monospacedSystemFont(ofSize: 13, weight: .medium)) -> [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.foregroundColor: color.nsColor,
                NSAttributedString.Key.font: font]
    }
}

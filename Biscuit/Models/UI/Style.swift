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
    let color: Color
    let font: NSFont

    init(color: Color,
         font: NSFont = NSFont.monospacedSystemFont(ofSize: 13, weight: .medium)) {
        self.color = color
        self.font = font
    }

    var attributes: [NSAttributedString.Key: Any] {
        [NSAttributedString.Key.foregroundColor: color.nsColor,
         NSAttributedString.Key.font: font]
    }
}

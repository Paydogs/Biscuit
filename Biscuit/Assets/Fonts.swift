//
//  Fonts.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 14..
//

import SwiftUI
import AppKit

enum Fonts {
    public static let plain: NSFont = .monospacedSystemFont(ofSize: 13, weight: .medium)
}

extension Fonts {
    static func defaultFont(sized: CGFloat,
                            weight: NSFont.Weight = .medium) -> NSFont {
        return NSFont.monospacedSystemFont(ofSize: sized, weight: weight)
    }
}

extension NSFont {
    var fontAttribute: [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.font: self]
    }

    var swiftUIFont: Font {
        Font(self)
    }
}

//
//  BiscuitJsonSyntaxHighlightingTheme.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 14..
//

import CoreGraphics
import Highlight
import AppKit

public struct BiscuitJsonSyntaxHighlightingTheme: JsonSyntaxHighlightingTheme {

    public init(fontSize size: CGFloat = 13) {
        whitespaceFont = .monospacedSystemFont(ofSize: size, weight: .medium)
        operatorFont = .monospacedSystemFont(ofSize: size, weight: .medium)
        numericValueFont = .monospacedSystemFont(ofSize: size, weight: .medium)
        stringValueFont = .monospacedSystemFont(ofSize: size, weight: .medium)
        literalFont = .monospacedSystemFont(ofSize: size, weight: .bold)
        unknownFont = .monospacedSystemFont(ofSize: size, weight: .medium)
    }

    public var memberKeyColor: Color = NSColor(Colors.JSON.memberKeyColor)

    public var whitespaceColor: Color = NSColor(Colors.JSON.whitespaceColor)

    public var whitespaceFont: Font

    public var operatorColor: Color = NSColor(Colors.JSON.operatorColor)

    public var operatorFont: Font

    public var numericValueColor: Color = NSColor(Colors.JSON.numericValueColor)

    public var numericValueFont: Font

    public var stringValueColor: Color = NSColor(Colors.JSON.stringValueColor)

    public var stringValueFont: Font

    public var literalColor: Color = NSColor(Colors.JSON.literalColor)

    public var literalFont: Font

    public var unknownColor: Color = NSColor(Colors.JSON.unknownColor)

    public var unknownFont: Font
}

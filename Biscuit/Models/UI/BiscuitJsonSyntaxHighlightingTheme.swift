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

    public var memberKeyColor: Color = Colors.JSON.memberKeyColor.nsColor

    public var whitespaceColor: Color = Colors.JSON.whitespaceColor.nsColor

    public var whitespaceFont: Font

    public var operatorColor: Color = Colors.JSON.operatorColor.nsColor

    public var operatorFont: Font

    public var numericValueColor: Color = Colors.JSON.numericValueColor.nsColor

    public var numericValueFont: Font

    public var stringValueColor: Color = Colors.JSON.stringValueColor.nsColor

    public var stringValueFont: Font

    public var literalColor: Color = Colors.JSON.literalColor.nsColor

    public var literalFont: Font

    public var unknownColor: Color = Colors.JSON.unknownColor.nsColor

    public var unknownFont: Font
}

public extension SyntaxHighlightProvider {
    func highlight(_ text: NSString) -> NSAttributedString {
        let result = NSMutableAttributedString(string: String(text))
        highlight(result, as: .json)
        return result
    }
}

//
//  String+Utils.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 25..
//
import Foundation

extension String {
    /// Convert `String` to base64 `Data`
    var base64Data: Data? {
        return Data(base64Encoded: self, options: .ignoreUnknownCharacters)
    }

    /// Converts `String` to `NSString`
    var nsValue: NSString {
        return NSString(string: self)
    }
}

extension String {
    /// Converts `String` to `NSAttributedString` with attributes provided by the `Style`
    func withStyle(_ style: Style? = nil) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: style?.attributes ?? [:])
    }
    /// Converts `String` to `NSMutableAttributedString` with attributes provided by the `Style`
    func mutableWithStyle(_ style: Style? = nil) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self, attributes: style?.attributes ?? [:])
    }

    /// Converts `String` to simple `NSAttributedString`
    var attributed: NSAttributedString {
        return NSAttributedString(string: self)
    }

    /// Converts `String` to simple `NSMutableAttributedString`
    var mutableAttributed: NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }
}

extension Optional where Wrapped == String {
    /// Converts optional `String` to simple `NSAttributedString`
    var attributed: NSAttributedString {
        return NSAttributedString(string: self ?? "")
    }

    /// Converts optional `String` to simple `NSMutableAttributedString`
    var mutableAttributed: NSMutableAttributedString {
        return NSMutableAttributedString(string: self ?? "")
    }

    /// Converts optional `String` to `NSAttributedString` with attributes provided by the `Style`
    func withStyle(_ style: Style? = nil) -> NSAttributedString {
        return NSAttributedString(string: self ?? "", attributes: style?.attributes ?? [:])
    }

    /// Converts optional `String` to `NSMutableAttributedString` with attributes provided by the `Style`
    func mutableWithStyle(_ style: Style? = nil) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self ?? "", attributes: style?.attributes ?? [:])
    }
}

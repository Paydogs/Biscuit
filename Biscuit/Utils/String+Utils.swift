//
//  String+Utils.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 25..
//
import Foundation

extension String {
    var base64Data: Data? {
        return Data(base64Encoded: self, options: .ignoreUnknownCharacters)
    }

    var nsValue: NSString {
        return NSString(string: self)
    }
}

extension String {
    func withStyle(_ style: Style? = nil) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: style?.attributes ?? [:])
    }
    func mutableWithStyle(_ style: Style? = nil) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self, attributes: style?.attributes ?? [:])
    }

    var attributed: NSAttributedString {
        return NSAttributedString(string: self)
    }

    var mutableAttributed: NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }
}

extension Optional where Wrapped == String {
    var attributed: NSAttributedString {
        return NSAttributedString(string: self ?? "")
    }

    var mutableAttributed: NSMutableAttributedString {
        return NSMutableAttributedString(string: self ?? "")
    }

    func withStyle(_ style: Style? = nil) -> NSAttributedString {
        return NSAttributedString(string: self ?? "", attributes: style?.attributes ?? [:])
    }

    func mutableWithStyle(_ style: Style? = nil) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self ?? "", attributes: style?.attributes ?? [:])
    }
}

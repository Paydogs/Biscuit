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
}

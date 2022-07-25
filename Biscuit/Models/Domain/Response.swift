//
//  Response.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 26..
//

import Foundation

struct Response {
    let headers: [String: String]
    var body: String?
}

extension Response {
    static func defaultValue() -> Response {
        return .init(headers: [:],
                     body: nil)
    }
}

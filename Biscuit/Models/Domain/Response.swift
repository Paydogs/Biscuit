//
//  Response.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 26..
//

import Foundation

struct Response {
    let headers: [String: String]
    var body: [String: Any]?
    var prettyBody: NSString?
    var rawBody: String?
}

extension Response: Equatable {
    static func == (lhs: Response, rhs: Response) -> Bool {
        return lhs.headers == rhs.headers && lhs.prettyBody == rhs.prettyBody && lhs.rawBody == rhs.rawBody
    }
}

extension Response {
    static func defaultValue() -> Response {
        return .init(headers: [:],
                     prettyBody: nil,
                     rawBody: nil)
    }
}

//
//  Request.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 26..
//

import Foundation

struct Request {
    var method: RequestMethod?
    let headers: [String: String]
    var body: [String: Any]?
    var prettyBody: NSString?
}

extension Request: Equatable {
    static func == (lhs: Request, rhs: Request) -> Bool {
        return lhs.method == rhs.method && lhs.headers == rhs.headers && lhs.prettyBody == rhs.prettyBody
    }
}

extension Request {
    static func defaultValue() -> Request {
        return .init(method: .unknown,
                     headers: [:],
                     prettyBody: nil)
    }
}

//
//  Request.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 26..
//

import Foundation

struct Request: Equatable {
    var method: RequestMethod?
    let headers: [String: String]
    var body: NSString?
}

extension Request {
    static func defaultValue() -> Request {
        return .init(method: .unknown,
                     headers: [:],
                     body: nil)
    }
}

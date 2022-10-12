//
//  Packet+Display.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 12..
//

import Foundation

extension Packet {
    var overviewDescription: String {
        let extraSeparator = "\n"
        let urlValue = "\(self.request.method?.rawValue ?? "") \(self.url)"
        let requestHeaderTitle = "REQUEST HEADERS:"
        let requestHeaderValue = self.request.headers.map { (key: String, value: String) -> String in
            return "\(key): \(value)"
        }
        let requestBodyTitle = "REQUEST BODY:"
        let requestBodyValue = String(self.request.body ?? "NIL")
        let bodyTitle = "RESPONSE BODY:"
        let bodyValue = String(self.response.prettyBody ?? "NIL")
        let elements: [String?] = [urlValue,
                                   extraSeparator,
                                   requestHeaderTitle,
                                   requestHeaderValue.joined(separator: "\n"),
                                   extraSeparator,
                                   requestBodyTitle,
                                   requestBodyValue,
                                   extraSeparator,
                                   bodyTitle,
                                   bodyValue]
        return elements.compactMap { $0 }.joined(separator: "\n")
    }
}

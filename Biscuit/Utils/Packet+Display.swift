//
//  Packet+Display.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 12..
//

import AppKit
import Highlight

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

    var colorizedOverviewDescription: NSAttributedString {
        let jsonHighlighter = JsonSyntaxHighlightProvider(theme: BiscuitJsonSyntaxHighlightingTheme())

        let extraSeparator =  NSAttributedString(string:"\n")
        let url = NSMutableAttributedString(string: self.request.method?.rawValue ?? "", attributes: Style.attributes(color: Colors.Overview.requestMethod))
        url.append(NSAttributedString(" "))
        url.append(NSMutableAttributedString(string: self.url, attributes: Style.attributes(color: Colors.Overview.headerValue)))

        let requestHeaderTitle =  NSAttributedString(string:"REQUEST HEADERS:", attributes: Style.attributes(color: Colors.Overview.category,
                                                                                                             font: Fonts.defaultFont(sized: 15)))
        let requestHeaderValue = self.request.headers.map { (key: String, value: String) -> NSAttributedString in
            let header = NSMutableAttributedString(string: key, attributes: Style.attributes(color: Colors.Overview.headerKey))
            header.append(NSAttributedString(string: ": ", attributes: Style.attributes(color: Colors.Overview.headerKey)))
            header.append(NSMutableAttributedString(string: value, attributes: Style.attributes(color: Colors.Overview.headerValue)))

            return header
        }
        let requestBodyTitle =  NSAttributedString(string:"REQUEST BODY:", attributes: Style.attributes(color: Colors.Overview.category,
                                                                                                        font: Fonts.defaultFont(sized: 15)))
        let requestBodyValue = jsonHighlighter.highlight(String(self.request.body ?? "NIL"), as: .json)
        let bodyTitle =  NSAttributedString(string:"RESPONSE BODY:", attributes: Style.attributes(color: Colors.Overview.category,
                                                                                                  font: Fonts.defaultFont(sized: 15)))
        let bodyValue = jsonHighlighter.highlight(String(self.response.prettyBody ?? "NIL"), as: .json)

        let elements: [NSAttributedString?] = [url,
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

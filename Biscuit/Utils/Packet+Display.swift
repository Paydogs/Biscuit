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
        let extraSeparator = Constants.newLine
        let urlValue = "\(self.request.method?.rawValue ?? "") \(self.url)"
        let requestHeaderTitle = Localized.packetRequestHeaders
        let requestHeaderValue = self.request.headers.map { (key: String, value: String) -> String in
            return "\(key): \(value)"
        }
        let requestBodyTitle = Localized.packetRequestBody
        let requestBodyValue = String(self.request.body ?? Localized.packetNil.nsValue)
        let bodyTitle = Localized.packetResponseBody
        let bodyValue = String(self.response.prettyBody ?? Localized.packetNil.nsValue)
        let elements: [String?] = [urlValue,
                                   extraSeparator,
                                   requestHeaderTitle,
                                   requestHeaderValue.joined(separator: Constants.newLine),
                                   extraSeparator,
                                   requestBodyTitle,
                                   requestBodyValue,
                                   extraSeparator,
                                   bodyTitle,
                                   bodyValue]
        return elements.compactMap { $0 }.joined(separator: Constants.newLine)
    }

    var colorizedOverviewDescription: NSAttributedString {
        let jsonHighlighter = JsonSyntaxHighlightProvider(theme: BiscuitJsonSyntaxHighlightingTheme())

        let extraSeparator =  Constants.newLine.attributed
        let url = self.request.method?.rawValue.mutableWithStyle(Constants.requestMethodStyle) ?? NSMutableAttributedString()
        url.append(" ".mutableAttributed)
        url.append(self.url.withStyle(Constants.headerKeyStyle))

        let requestHeaderTitle = Localized.packetRequestHeaders.withStyle(Constants.categoryStyle)
        let requestHeaderValue = self.request.headers.map { (key: String, value: String) -> NSAttributedString in
            let header = key.mutableWithStyle(Constants.headerKeyStyle)
            header.append(": ".mutableWithStyle(Constants.headerKeyStyle))
            header.append(value.withStyle(Constants.headerValueStyle))
            return header
        }
        let requestBodyTitle =  Localized.packetRequestBody.withStyle(Constants.categoryStyle)
        let requestBodyValue = jsonHighlighter.highlight(self.request.body ?? Localized.packetNil.nsValue)
        let bodyTitle =  Localized.packetResponseBody.withStyle(Constants.categoryStyle)
        let bodyValue = jsonHighlighter.highlight(self.response.prettyBody ?? Localized.packetNil.nsValue)

        let elements: [NSAttributedString?] = [url,
                                extraSeparator,
                                requestHeaderTitle,
                                requestHeaderValue.joined(separator: Constants.newLine),
                                extraSeparator,
                                requestBodyTitle,
                                requestBodyValue,
                                extraSeparator,
                                bodyTitle,
                                bodyValue]
        return elements.compactMap { $0 }.joined(separator: Constants.newLine)
    }
}

private extension Packet {
    enum Constants {
        static let newLine = "\n"
        static let categoryStyle = Style(color: Colors.Overview.category,
                                        font: Fonts.defaultFont(sized: 15))
        static let requestMethodStyle = Style(color: Colors.Overview.requestMethod)
        static let headerKeyStyle = Style(color: Colors.Overview.headerKey)
        static let headerValueStyle = Style(color: Colors.Overview.headerValue)
    }
}

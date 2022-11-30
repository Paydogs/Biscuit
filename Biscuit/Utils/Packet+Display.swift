//
//  Packet+Display.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 12..
//

import AppKit
import Highlight

extension Packet {
    var colorizedOverviewDescription: NSAttributedString {
        let extraSeparator =  Constants.newLine.attributed
        let url = self.request.method?.rawValue.mutableWithStyle(Constants.requestMethodStyle) ?? NSMutableAttributedString()
        url.append(" ".mutableAttributed)
        url.append(self.url.withStyle(Constants.headerKeyStyle))

        let requestHeaderTitle = Localized.packetRequestHeaders.withStyle(Constants.categoryStyle)
        let requestBodyTitle =  Localized.packetRequestBody.withStyle(Constants.categoryStyle)
        let bodyTitle =  Localized.packetResponseBody.withStyle(Constants.categoryStyle)

        let elements: [NSAttributedString?] = [url,
                                extraSeparator,
                                requestHeaderTitle,
                                colorizedRequestHeader,
                                extraSeparator,
                                requestBodyTitle,
                                colorizedRequestBody,
                                extraSeparator,
                                bodyTitle,
                                colorizedResponseBody]
        return elements.compactMap { $0 }.joined(separator: Constants.newLine)
    }

    var colorizedRequestHeader: NSAttributedString {
        return self.request.headers.map { (key: String, value: String) -> NSAttributedString in
            let header = key.mutableWithStyle(Constants.headerKeyStyle)
            header.append(": ".mutableWithStyle(Constants.headerKeyStyle))
            header.append(value.withStyle(Constants.headerValueStyle))
            return header
        }
        .joined(separator: Constants.newLine)
    }

    var colorizedRequestBody: NSAttributedString {
        let jsonHighlighter = JsonSyntaxHighlightProvider(theme: BiscuitJsonSyntaxHighlightingTheme())
        return jsonHighlighter.highlight(self.request.body ?? Localized.packetEmpty.nsValue)
    }

    var colorizedResponseBody: NSAttributedString {
        let jsonHighlighter = JsonSyntaxHighlightProvider(theme: BiscuitJsonSyntaxHighlightingTheme())
        return jsonHighlighter.highlight(self.response.prettyBody ?? Localized.packetEmpty.nsValue)
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

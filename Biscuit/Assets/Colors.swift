//
//  Colors.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 13..
//

import AppKit
import SwiftUI

enum Colors {
    enum Background {
        public static let panelBackground = Color(biscuitName: "PanelBackground")
        public static let bubbleBackground = Color(biscuitName: "BubbleBackground")
    }
    enum DeviceStatus {
        public static let activeStatus = Color(biscuitName: "StatusActive")
        public static let offlineStatus = Color(biscuitName: "StatusOffline")
    }
    enum StatusCode {
        public static let http2xx = Color(defaultName: "200-Successful")
//        public static let http2xx = Color(biscuitName: "StatusCodeGreen")
        public static let http4xx = Color(biscuitName: "StatusCodeRed")
        public static let defaultColor = Color(biscuitName: "StatusCodeDefault")
    }
    enum RequestMethod {
        public static let get = Color(biscuitName: "RequestMethodGet")
        public static let post = Color(biscuitName: "RequestMethodPost")
        public static let delete = Color(biscuitName: "RequestMethodDelete")
        public static let put = Color(biscuitName: "RequestMethodPut")
        public static let defaultColor = Color(biscuitName: "RequestMethodDefault")
    }
    enum JSON {
        public static let memberKeyColor = Color(biscuitName: "MemberKeyColor")
        public static let whitespaceColor = Color(biscuitName: "WhitespaceColor")
        public static let operatorColor = Color(biscuitName: "OperatorColor")
        public static let numericValueColor = Color(biscuitName: "NumericValueColor")
        public static let stringValueColor = Color(biscuitName: "StringValueColor")
        public static let literalColor = Color(biscuitName: "LiteralColor")
        public static let unknownColor = Color(biscuitName: "UnknownColor")
    }
    enum Overview {
        public static let category = Color(biscuitName: "Category")
        public static let headerKey = Color(biscuitName: "HeaderKey")
        public static let headerValue = Color(biscuitName: "HeaderValue")
        public static let requestMethod = Color(biscuitName: "RequestMethod")
    }
}

extension Color {
    init(biscuitName: String) {
        self = Color.init(biscuitName, bundle: Bundle(identifier: "Colors"))
    }

    init(defaultName: String) {
        print("scheme: \(NSApp.effectiveAppearance.name)")
        self = .white
    }

    var nsColor: NSColor {
        return NSColor(self)
    }
}

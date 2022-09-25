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
        public static let http2xx = Color(biscuitName: "StatusCodeGreen")
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
}

extension Color {
    init(biscuitName: String) {
        self = Color.init(biscuitName, bundle: Bundle(identifier: "Colors"))
    }
}

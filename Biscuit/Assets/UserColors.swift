//
//  UserColors.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 13..
//

import AppKit
import SwiftUI

enum UserColors {
    enum Background {
        public static let panelBackground = DefaultDarkColors.Backgrounds.PanelBackground
        public static let bubbleBackground = DefaultDarkColors.Backgrounds.BubbleBackground
    }
    enum DeviceStatus {
        public static let activeStatus = DefaultDarkColors.DeviceStatus.StatusActive
        public static let offlineStatus = DefaultDarkColors.DeviceStatus.StatusOffline
    }
    enum StatusCode {
        public static let http2xx = DefaultDarkColors.HttpStatusCode.Http2xx
        public static let http4xx = DefaultDarkColors.HttpStatusCode.Http4xx
        public static let defaultColor = DefaultDarkColors.HttpStatusCode.Default
    }
    enum RequestMethod {
        public static let get = DefaultDarkColors.RequestMethod.RequestMethodGet
        public static let post = DefaultDarkColors.RequestMethod.RequestMethodPost
        public static let delete = DefaultDarkColors.RequestMethod.RequestMethodDelete
        public static let put = DefaultDarkColors.RequestMethod.RequestMethodPut
        public static let defaultColor = DefaultDarkColors.RequestMethod.RequestMethodDefault
    }
    enum JSON {
        public static let memberKeyColor = DefaultDarkColors.JSON.MemberKey
        public static let whitespaceColor = DefaultDarkColors.JSON.Whitespace
        public static let operatorColor = DefaultDarkColors.JSON.Operator
        public static let numericValueColor = DefaultDarkColors.JSON.NumericValue
        public static let stringValueColor = DefaultDarkColors.JSON.StringValue
        public static let literalColor = DefaultDarkColors.JSON.LiteralValue
        public static let unknownColor = DefaultDarkColors.JSON.Unknown
    }
    enum Overview {
        public static let category = DefaultDarkColors.Overview.Category
        public static let headerKey = DefaultDarkColors.Overview.HeaderKey
        public static let headerValue = DefaultDarkColors.Overview.HeaderValue
        public static let requestMethod = DefaultDarkColors.Overview.RequestMethod
    }
}

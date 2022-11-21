//
//  Colors.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 12..
//

import AppKit
import SwiftUI

enum Colors {
    enum Text {
        public static let primaryText = GeneratedColors.Text.primary.swiftUIColor
        public static let secondaryText = GeneratedColors.Text.secondary.swiftUIColor
    }
    enum Defaults {
        public static let white = GeneratedColors.Defaults.white.swiftUIColor
        public static let green = GeneratedColors.Defaults.green.swiftUIColor
        public static let indigo = GeneratedColors.Defaults.indigo.swiftUIColor
        public static let lightBlue = GeneratedColors.Defaults.lightBlue.swiftUIColor
        public static let mediumBlue = GeneratedColors.Defaults.mediumBlue.swiftUIColor
        public static let orange = GeneratedColors.Defaults.orange.swiftUIColor
        public static let purple = GeneratedColors.Defaults.purple.swiftUIColor
        public static let red = GeneratedColors.Defaults.red.swiftUIColor
        public static let yellow = GeneratedColors.Defaults.yellow.swiftUIColor
    }
    enum View {
        public static let mainBackground = GeneratedColors.View.mainBackground.swiftUIColor
    }
    enum DeviceStatus {
        public static let activeStatus = GeneratedColors.DeviceStatus.statusActive.swiftUIColor
        public static let offlineStatus = GeneratedColors.DeviceStatus.statusOffline.swiftUIColor
    }
    enum StatusCode {
        public static let http2xx = GeneratedColors.HttpStatusCode.http2xx.swiftUIColor
        public static let http4xx = GeneratedColors.HttpStatusCode.http4xx.swiftUIColor
        public static let defaultColor = GeneratedColors.HttpStatusCode.httpDefault.swiftUIColor
    }
    enum RequestMethod {
        public static let get = GeneratedColors.RequestMethod.requestMethodGet.swiftUIColor
        public static let post = GeneratedColors.RequestMethod.requestMethodPost.swiftUIColor
        public static let delete = GeneratedColors.RequestMethod.requestMethodDelete.swiftUIColor
        public static let put = GeneratedColors.RequestMethod.requestMethodPut.swiftUIColor
        public static let defaultColor = GeneratedColors.RequestMethod.requestMethodDefault.swiftUIColor
    }
    enum JSON {
        public static let memberKeyColor = GeneratedColors.Json.memberKey.swiftUIColor
        public static let whitespaceColor = GeneratedColors.Json.whitespace.swiftUIColor
        public static let operatorColor = GeneratedColors.Json.operator.swiftUIColor
        public static let numericValueColor = GeneratedColors.Json.numericValue.swiftUIColor
        public static let stringValueColor = GeneratedColors.Json.stringValue.swiftUIColor
        public static let literalColor = GeneratedColors.Json.literalValue.swiftUIColor
        public static let unknownColor = GeneratedColors.Json.unknown.swiftUIColor
    }
    enum Overview {
        public static let background = GeneratedColors.Text.textBackground.swiftUIColor
        public static let category = GeneratedColors.Defaults.orange.swiftUIColor
        public static let headerKey = GeneratedColors.Text.secondary.swiftUIColor
        public static let headerValue = GeneratedColors.Text.primary.swiftUIColor
        public static let requestMethod = GeneratedColors.Defaults.orange.swiftUIColor
    }
    enum ErrorView {
        public static let background = GeneratedColors.Defaults.red.swiftUIColor
        public static let foreground = GeneratedColors.Text.primary.swiftUIColor
    }
    enum HeaderView {
        public static let background = GeneratedColors.HeaderView.headerBackground.swiftUIColor
    }
}

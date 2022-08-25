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
    enum Status {
        public static let activeStatus = Color(biscuitName: "StatusActive")
        public static let offlineStatus = Color(biscuitName: "StatusOffline")
    }
}

extension Color {
    init(biscuitName: String) {
        self = Color.init(biscuitName, bundle: Bundle(identifier: "Colors"))
    }
}

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
    }
}

extension Color {
    init(biscuitName: String) {
        self = Color.init(biscuitName, bundle: Bundle(identifier: "Colors"))
    }
}

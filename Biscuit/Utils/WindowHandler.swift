//
//  WindowHandler.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 12. 04..
//

import AppKit

/// Simple helper to open a window.
/// Known side effect: You can open a window multiple time
struct WindowHandler {
    /// Opens a window as "biscuiturl://xyz", described in the WindowName property
    static func open(window: WindowName) {
        guard let url = URL(string: "biscuiturl://\(window.rawValue)") else { return }
        NSWorkspace.shared.open(url)
    }
}

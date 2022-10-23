//
//  AppDelegate.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 23..
//

import AppKit
import SwiftUI
import Factory
import Combine

class AppDelegate: NSObject, NSApplicationDelegate {
    @Injected(BiscuitContainer.core) private var core

    func applicationDidFinishLaunching(_ notification: Notification) {
        core.startup()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

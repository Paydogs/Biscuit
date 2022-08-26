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
    @Injected(BiscuitContainer.connector) private var connector

    func applicationWillFinishLaunching(_ notification: Notification) {
        BiscuitCore.startup()
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        connector.start()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

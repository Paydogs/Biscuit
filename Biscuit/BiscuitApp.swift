//
//  BiscuitApp.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 23..
//

import SwiftUI
import Factory
import Combine

@main
struct BiscuitApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Injected(BiscuitContainer.menuController) var menuController

    init() { }

    var body: some Scene {
        WindowGroup {
            MainWindow()
        }
        .windowStyle(.hiddenTitleBar)
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button(action: { menuController.openAboutWindow() }) {
                    Text(Localized.MenuItem.aboutView) }
            }
            CommandGroup(after: .newItem) {
                Divider()
                Button(action: { menuController.exportPackets() }) {
                    Text(Localized.MenuItem.exportPackets)
                }
                Divider()
                Button(action: { menuController.deleteOfflineDevices() }) {
                    Text(Localized.MenuItem.clearOfflineDevice)
                }
            }
        }

        WindowGroup() {
            AboutView()
        }
        .windowStyle(.hiddenTitleBar)
        .handlesExternalEvents(matching: [WindowName.about.rawValue])
    }
}

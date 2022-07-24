//
//  BiscuitApp.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 23..
//

import SwiftUI

@main
struct BiscuitApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var oldConnector = OldConnector()
    var connector = Connector()

    init() {
        start()
    }

    var body: some Scene {
        WindowGroup {
            MainWindow()
        }
    }

    func start() {
//        oldConnector.start2()
        connector.start()
    }
}

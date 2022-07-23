//
//  BiscuitApp.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 23..
//

import SwiftUI

@main
struct BiscuitApp: App, BagelPublisherDelegate {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var publisher = BagelPublisher()
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
//        self.publisher.delegate = self
//        publisher.startPublishing()
        connector.start2()
    }

    func didGetPacket(publisher: BagelPublisher, packet: BagelPacket) {
        NSLog("Received something: from: \(publisher), packet: \(packet)")
    }
}

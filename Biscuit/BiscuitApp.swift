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

    @Injected(Container.dispatcher) private var dispatcher
    @Injected(Container.messageStore) private var messageStore
    @Injected(Container.connector) private var connector

    var subscription: AnyCancellable?

    init() {
        start()
        peak()
    }

    var body: some Scene {
        WindowGroup {
            MainWindow()
        }
    }

    func start() {
        dispatcher.registerStore(store: messageStore)
        connector.start()
    }

    mutating func peak() {
        subscription = messageStore.$state.sink { (value: MessageState) in
            let messages = value.messages
            print("\nMessage store count: \(messages.count)")
            messages.map { $0.quickDescription() }
        }
    }
}

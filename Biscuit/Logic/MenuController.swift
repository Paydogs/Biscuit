//
//  MenuController.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 23..
//

import SwiftUI
import Combine
import Factory

struct MenuController {
    @Injected(BiscuitContainer.appStore) var appStore
    @Injected(BiscuitContainer.packetStore) var packetStore
    @Injected(BiscuitContainer.dispatcher) var dispatcher

    private var subscriptions: Set<AnyCancellable> = []
}

// MARK: - Menu items
extension MenuController {
    func openAboutWindow() {
        WindowHandler.open(window: WindowName.about)
    }
    func exportPackets() {
        print("[MenuController] Exporting packets...")
        SavePanel.exportPacketBodies(packets: appStore.observed.state.selectedPackets)
    }
    func deleteOfflineDevices() {
        print("[MenuController] Deleting offline devices")
        let action = PacketActions.deleteOfflineDevices
        dispatcher.dispatch(action: action)
    }
}

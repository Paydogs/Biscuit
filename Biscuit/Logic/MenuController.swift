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
        SavePanel.exportPacketBodies(packets: getSelectedPackets())
    }
    func deleteOfflineDevices() {
        print("[MenuController] Deleting offline devices")
        let action = PacketActions.deleteOfflineDevices
        dispatcher.dispatch(action: action)
    }
}

private extension MenuController {
    func getSelectedPackets() -> [Packet] {
        let packetIds = appStore.observed.state.selectedPacketIds
        let packets = packetStore.observed.state.projects.allPackets().filter { packet in
            packetIds.contains(packet.id)
        }
        return packets
    }
}

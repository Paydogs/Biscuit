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

    private var subscriptions: Set<AnyCancellable> = []
}

// MARK: - Menu items
extension MenuController {
    func exportPackets() {
        print("[MenuController] Exporting packets...")
        SavePanel.exportPackets(packets: appStore.observed.state.selectedPackets)
    }
}

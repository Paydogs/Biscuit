//
//  MenuController.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 23..
//

import SwiftUI
import Combine

struct MenuController {
    private let appState: Observed<AppState>
    private let packetState: Observed<PacketState>

    private var subscriptions: Set<AnyCancellable> = []

    init(appState: Observed<AppState>,
         packetState: Observed<PacketState>) {
        self.appState = appState
        self.packetState = packetState
    }
}

// MARK: - Menu items
extension MenuController {
    func exportPackets() {
        print("[MenuController] Exporting packets...")
        SavePanel.exportPackets(packets: appState.state.selectedPackets)
    }
}

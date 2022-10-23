//
//  AppController.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 28..
//

import SwiftUI
import Factory
import Combine

class AppController: ObservableObject {
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
extension AppController {
    func exportPackets() {
        exportPackets(packets: appState.state.selectedPackets)
    }
}

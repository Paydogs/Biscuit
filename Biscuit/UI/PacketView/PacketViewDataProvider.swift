//
//  PacketViewDataProvider.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 28..
//

import SwiftUI
import Factory
import Combine

class PacketViewDataProvider {
    @ObservedObject var domain: PacketViewDomain

    private let appState: Observed<AppState>
    private let packetState: Observed<PacketState>

    private var subscriptions: Set<AnyCancellable> = []

    init(appState: Observed<AppState>,
         packetState: Observed<PacketState>) {
        self.appState = appState
        self.packetState = packetState

        domain =  PacketViewDomain()
        subscribe()
    }

    func subscribe() {
        appState.$state.map(\.selectedPackets.first)
            .sink(receiveValue: { [weak self] value in
                self?.domain.selectedPacket = value
            })
            .store(in: &subscriptions)
    }
}

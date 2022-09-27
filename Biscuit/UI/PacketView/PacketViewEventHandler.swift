//
//  PacketViewEventHandler.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 28..
//

import Foundation

protocol PacketViewEventHandling {

}

struct PacketViewEventHandler {
    private let appState: Observed<AppState>
    private let packetState: Observed<PacketState>

    init(appState: Observed<AppState>,
         packetState: Observed<PacketState>) {
        self.appState = appState
        self.packetState = packetState
    }
}

extension PacketViewEventHandler: PacketViewEventHandling {
}

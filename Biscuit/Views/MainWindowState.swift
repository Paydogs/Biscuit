//
//  MainWindowState.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 28..
//

import SwiftUI
import Factory
import Combine

class MainWindowState: ObservableObject {
    @ObservedObject var packetState: Observed<PacketState>

    @Published var logContainerData: LogContainer.Data

    var subscriptions: Set<AnyCancellable> = []

    init(packetState: Observed<PacketState>) {
        self.packetState = packetState
        let packets = packetState.state.projects.first?.devices.first?.packets ?? []
        logContainerData = LogContainer.Data(packets: PacketTableRowUIMapper.getPacketRows(list: packets))
        subscribe()
    }

    func subscribe() {
        packetState.$state.sink(receiveValue: { [weak self] state in
            let packets = state.projects.first?.devices.first?.packets ?? []
            self?.logContainerData = LogContainer.Data(packets: PacketTableRowUIMapper.getPacketRows(list: packets))
        })
        .store(in: &subscriptions)
    }
}

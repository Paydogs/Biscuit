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

    @Published var headerData: HeaderComponent.Data
    @Published var headerEvents: HeaderComponent.Event?
    @Published var logContainerData: LogContainer.Data

    var subscriptions: Set<AnyCancellable> = []

    init(packetState: Observed<PacketState>) {
        self.packetState = packetState
        let packets = packetState.state.projects.first?.devices.first?.packets ?? []
        headerData = HeaderComponent.Data(projectList: [], deviceList: [])
        logContainerData = LogContainer.Data(packets: PacketTableRowUIMapper.getPacketRows(list: packets))
        subscribe()
    }

    func subscribe() {
        packetState.$state.sink(receiveValue: { [weak self] state in
            let packets = state.projects.first?.devices.first?.packets ?? []
            self?.headerData = HeaderComponent.Data(projectList: HeaderComponentUIMapper.getProjectNameList(list: state.projects),
                                              deviceList: [])
            self?.logContainerData = LogContainer.Data(packets: PacketTableRowUIMapper.getPacketRows(list: packets))
        })
        .store(in: &subscriptions)
    }
}

//
//  LogViewDataProvider.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 18..
//

import SwiftUI
import Factory
import Combine

class LogViewDataProvider {
    @ObservedObject var domain: LogViewDomain

    private let appState: Observed<AppState>
    private let packetState: Observed<PacketState>

    private var subscriptions: Set<AnyCancellable> = []

    init(appState: Observed<AppState>,
         packetState: Observed<PacketState>) {
        self.appState = appState
        self.packetState = packetState

        domain =  LogViewDomain()
        subscribe()
    }

    func subscribe() {
        packetState.$state.map(\.projects)
            .combineLatest(appState.$state.map(\.filter))
            .map { (projects: Set<Project>, filter: Filter) in
                projects.filterPackets(filter: filter).compactMap { [weak self] packet -> PacketTableRow? in
                    guard let self = self else { return nil }
                    return self.mapPacket(packet: packet)
                }
            }
            .sink(receiveValue: { [weak self] value in
                self?.domain.packets = value
            })
            .store(in: &subscriptions)
    }
}

private extension LogViewDataProvider {
    func mapPacket(packet: Packet) -> PacketTableRow {
        return .init(id: packet.bagelPacketId, status: packet.statusCode, method: packet.request.method?.rawValue ?? "", url: packet.url, date: packet.startDate.formatted())
    }
}

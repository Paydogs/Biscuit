//
//  LogAreaDataProvider.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 18..
//

import SwiftUI
import Factory
import Combine

class LogAreaDataProvider {
    @ObservedObject var domain: LogAreaDomain

    private let appState: Observed<AppState>
    private let packetState: Observed<PacketState>

    private var subscriptions: Set<AnyCancellable> = []

    init(appState: Observed<AppState>,
         packetState: Observed<PacketState>) {
        self.appState = appState
        self.packetState = packetState

        domain =  LogAreaDomain()
        subscribe()
    }

    func subscribe() {
        appState.$state.map(\.selectedDevice)
            .combineLatest(packetState.$state)
            .map { [weak self] (device, packetState) -> [PacketTableRow] in
                guard let self = self,
                    let device = device else { return []}

                print("FUCK device: \(device), packetState: \(device.packets.count)")
                return device.packets.sorted().map(self.mapPacket)
            }
            .sink(receiveValue: { [weak self] value in
                self?.domain.packets = value
            })
            .store(in: &subscriptions)
    }
}

private extension LogAreaDataProvider {
    func mapPacket(packet: Packet) -> PacketTableRow {
        return .init(id: packet.bagelPacketId, status: packet.statusCode, method: packet.request.method?.rawValue ?? "", url: packet.url, date: packet.startDate.formatted())
    }
}

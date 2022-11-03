//
//  LogViewController.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 12..
//

import SwiftUI
import Factory
import Combine

protocol LogViewEventHandling {
    func selectPackets(identifiers: [String])
    func exportPackets()
}

class LogViewController {
    @ObservedObject var domain = LogViewDomain()

    private let appState: Observed<AppState>
    private let packetState: Observed<PacketState>
    private let selectPacketsUseCase: SelectPacketsUseCaseInterface
    private var subscriptions: Set<AnyCancellable> = []

    init(appState: Observed<AppState>,
         packetState: Observed<PacketState>,
         selectPacketsUseCase: SelectPacketsUseCaseInterface) {
        self.appState = appState
        self.packetState = packetState
        self.selectPacketsUseCase = selectPacketsUseCase
        bind()
    }
}

// MARK: - Data providing
private extension LogViewController {
    func bind() {
        packetState.$state.map(\.projects)
            .combineLatest(appState.$state.map(\.filter))
            .map { (projects: Set<Project>, filter: Filter) in
                projects.filterPackets(filter: filter)
                    .sorted()
                    .compactMap { [weak self] packet -> PacketTableRow? in
                    guard let self = self else { return nil }
                    return self.mapPacket(packet: packet)
                }
            }
            .sink(receiveValue: { [weak self] value in
                self?.domain.packets = value
            })
            .store(in: &subscriptions)
    }

    func mapPacket(packet: Packet) -> PacketTableRow {
        return .init(id: packet.bagelPacketId,
                     status: String(packet.statusCode.code),
                     statusColor: packet.statusCode.color,
                     method: packet.request.method?.rawValue ?? "",
                     methodColor: packet.request.method?.color ?? Color.white,
                     url: packet.url,
                     date: packet.startDate.formatted())
    }
}

// MARK: - Event listening
extension LogViewController: LogViewEventHandling {
    func selectPackets(identifiers: [String]) {
        print("Selecting: \(identifiers)")
        let packets = packetState.state.projects.filterPackets(filter: appState.state.filter).filter { packet in
            identifiers.contains(packet.id)
        }
        print("packets to select: \(identifiers)")
        selectPacketsUseCase.execute(packets: packets)
    }

    func exportPackets() {
        SavePanel.exportPackets(packets: appState.state.selectedPackets)
    }
}

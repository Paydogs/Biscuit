//
//  LogViewViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 06..
//

import Foundation
import AppKit
import Factory
import Combine
import SwiftUI

protocol LogViewViewModelInterface: ObservableObject {
    var packets: [PacketTableRow] { get }

    func selectPackets(identifiers: [String])
    func exportPackets()
}

class LogViewViewModel: LogViewViewModelInterface {
    @Injected(BiscuitContainer.appStore) private var appStore
    @Injected(BiscuitContainer.packetStore) private var packetStore
    @Injected(BiscuitContainer.selectPacketsUseCase) private var selectPacketsUseCase
    private var subscriptions: Set<AnyCancellable> = []

    @Published var packets: [PacketTableRow] = []

    init() {
        packetStore.observed.$state.map(\.projects)
            .combineLatest(appStore.observed.$state.map(\.filter))
            .map { (projects: Set<Project>, filter: Filter) in
                projects.filterPackets(filter: filter)
                    .sorted()
                    .compactMap { [weak self] packet -> PacketTableRow? in
                    guard let self = self else { return nil }
                    return self.mapPacket(packet: packet)
                }
            }
            .sink(receiveValue: { [weak self] value in
                self?.packets = value
            })
            .store(in: &subscriptions)
    }
}

private extension LogViewViewModel {
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

// MARK: - Event handling
extension LogViewViewModel {
    func selectPackets(identifiers: [String]) {
        print("Selecting: \(identifiers)")
        let packets = packetStore.observed.state.projects.filterPackets(filter: appStore.observed.state.filter).filter { packet in
            identifiers.contains(packet.id)
        }
        print("packets to select: \(identifiers)")
        selectPacketsUseCase.execute(packets: packets)
    }

    func exportPackets() {
        SavePanel.exportPackets(packets: appStore.observed.state.selectedPackets)
    }
}

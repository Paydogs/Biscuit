//
//  LogViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 06..
//

import Foundation
import AppKit
import Factory
import Combine
import SwiftUI

protocol LogViewModelInterface: ObservableObject {
    var packets: [PacketTableRow] { get }

    func selectPackets(identifiers: [String])
    func exportPackets()
    func filterUrl(url: String)
}

class LogViewModel: LogViewModelInterface {
    @Injected(BiscuitContainer.appStore) private var appStore
    @Injected(BiscuitContainer.packetStore) private var packetStore
    @Injected(BiscuitContainer.selectPacketsUseCase) private var selectPacketsUseCase
    @Injected(BiscuitContainer.updatePacketFilterUseCase) private var updatePacketFilterUseCase
    private var subscriptions: Set<AnyCancellable> = []

    @Published var packets: [PacketTableRow] = []

    init() {
        packetStore.observed.$state.map(\.projects)
            .combineLatest(appStore.observed.$state.map(\.buildFilter))
            .map { (projects: Set<Project>, buildFilter: BuildFilter) -> [Packet] in
                projects.filterDevices(filter: buildFilter).first?.packets.sorted() ?? []
            }
            .combineLatest(appStore.observed.$state.map(\.packetFilter))
            .map { (devicePackets: [Packet], packetFilter: PacketFilter) -> [Packet] in
                return devicePackets.filteredPackets(filter: packetFilter)
            }
            .map { [weak self] (filteredPackets: [Packet]) -> [PacketTableRow] in
                guard let self = self else { return [] }
                return filteredPackets.compactMap(self.mapPacket(packet:))
            }
            .sink(receiveValue: { [weak self] value in
                self?.packets = value
            })
            .store(in: &subscriptions)
    }
}

private extension LogViewModel {
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
extension LogViewModel {
    func selectPackets(identifiers: [String]) {
        print("Selecting: \(identifiers)")
        let allPackets = packetStore.observed.state.projects.allPackets()
        let packets = allPackets.filter { (packet: Packet) in identifiers.contains(packet.id) }
        print("packets to select: \(identifiers)")
        selectPacketsUseCase.execute(packets: packets)
    }

    func exportPackets() {
        SavePanel.exportPackets(packets: appStore.observed.state.selectedPackets)
    }

    func filterUrl(url: String) {
        print("Filtering: \(url)")
        updatePacketFilterUseCase.execute(filter: PacketFilter(url: url))
    }
}
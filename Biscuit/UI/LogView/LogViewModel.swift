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
    var hasTimeFilter: Bool { get }

    func selectPackets(identifiers: [String])
    func pinPackets(identifiers: [String])
    func unpinPackets(identifiers: [String])
    func exportPackets()
    func filterUrl(url: String)
    func clearFromLastSelected()
    func hideCurrentMessages()
    func resetMessageHiding()
}

class LogViewModel: LogViewModelInterface {
    @Injected(BiscuitContainer.appStore) private var appStore
    @Injected(BiscuitContainer.packetStore) private var packetStore
    @Injected(BiscuitContainer.dispatcher) private var dispatcher
    private var subscriptions: Set<AnyCancellable> = []

    @Published var packets: [PacketTableRow] = []
    @Published var hasTimeFilter: Bool = false

    init() {
        packetStore.observed.$state.map(\.projects)
            .combineLatest(appStore.observed.$state.map(\.buildFilter))
            .map { (projects: Set<Project>, buildFilter: BuildFilter) -> [Packet] in
                projects.packetsOfDeviceInFilter(filter: buildFilter).sorted()
            }
            .combineLatest(appStore.observed.$state.map(\.packetFilter))
            .map { [weak self] (devicePackets: [Packet], packetFilter: PacketFilter) -> [Packet] in
                if case .date = packetFilter.from {
                    self?.hasTimeFilter = true
                } else if case .date = packetFilter.to {
                    self?.hasTimeFilter = true
                } else {
                    self?.hasTimeFilter = false
                }
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
                     pinned: packet.pinned,
                     status: String(packet.statusCode.code),
                     statusColor: packet.statusCode.color,
                     method: packet.request.method?.rawValue ?? "",
                     methodColor: packet.request.method?.color ?? Colors.Defaults.white,
                     url: packet.url,
                     date: packet.startDate.formatted())
    }
}

// MARK: - Event handling
extension LogViewModel {
    func selectPackets(identifiers: [String]) {
        let allPackets = packetStore.observed.state.projects.allPackets()
        let packets = allPackets.filter { (packet: Packet) in identifiers.contains(packet.id) }
        print("packets to select: \(identifiers)")
        let action = AppActions.didSelectPackets(packets)
        dispatcher.dispatch(action: action)
    }

    func togglePacketPinning(identifiers: [String]) {
        print("Toggling pinning on: \(identifiers)")
        let action = PacketActions.didTogglePacketPinStatus(identifiers)
        dispatcher.dispatch(action: action)
    }

    func pinPackets(identifiers: [String]) {
        print("Turning pinning on: \(identifiers)")
        let action = PacketActions.didSetPacketPinStatusOn(identifiers)
        dispatcher.dispatch(action: action)
    }

    func unpinPackets(identifiers: [String]) {
        print("Turning pinning off: \(identifiers)")
        let action = PacketActions.didSetPacketPinStatusOff(identifiers)
        dispatcher.dispatch(action: action)
    }

    func exportPackets() {
        print("Trying to export packets: \(appStore.observed.state.selectedPackets.count)")
        SavePanel.exportPacketBodies(packets: appStore.observed.state.selectedPackets)
    }

    func filterUrl(url: String) {
        print("Filtering: \(url)")
        let action = AppActions.didModifiedPacketFilter(PacketFilter(url: url))
        dispatcher.dispatch(action: action)
    }

    func clearFromLastSelected() {
        guard let first = appStore.observed.state.selectedPackets.last else { return }
        print("Clearing from first selected packet")
        let action = AppActions.didModifiedPacketFilter(PacketFilter(from: .date(first.received)))
        dispatcher.dispatch(action: action)
    }

    func hideCurrentMessages() {
        print("Hide current messages")
        let action = AppActions.didModifiedPacketFilter(PacketFilter(from: .date(Double(Date().timeIntervalSince1970))))
        dispatcher.dispatch(action: action)
    }

    func resetMessageHiding() {
        print("Reset message hiding")
        let action = AppActions.didModifiedPacketFilter(PacketFilter(from: .reset))
        dispatcher.dispatch(action: action)
    }
}

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
    var reset: PassthroughSubject<Bool, Never> { get }

    func selectPackets(identifiers: [String])
    func pinPackets(identifiers: [String])
    func unpinPackets(identifiers: [String])
    func exportPackets()
    func exportPacketsAndZip()
    func filterUrl(url: String)
    func deleteFromLastSelected()
    func hideFromLastSelected()
    func deleteCurrentMessages()
    func hideCurrentMessages()
    func resetMessageHiding()
}

class LogViewModel: LogViewModelInterface {
    @Injected(BiscuitContainer.appStore) private var appStore
    @Injected(BiscuitContainer.packetStore) private var packetStore
    @Injected(BiscuitContainer.dispatcher) private var dispatcher
    private var subscriptions: Set<AnyCancellable> = []
    private var selectedDevice: String?

    @Published var packets: [PacketTableRow] = []
    @Published var hasTimeFilter: Bool = false
    let reset = PassthroughSubject<Bool, Never>()

    init() {
        packetStore.observed.$state.map(\.projects)
            .combineLatest(appStore.observed.$state.map(\.buildFilter))
            .map { [weak self] (projects: Set<Project>, buildFilter: BuildFilter) -> [Packet] in
                if self?.selectedDevice != buildFilter.deviceId {
                    self?.selectedDevice = buildFilter.deviceId
                    self?.reset.send(true)
                }
                return projects.packetsOfDeviceInFilter(filter: buildFilter).sorted()
            }
            .combineLatest(appStore.observed.$state.map(\.packetFilter))
            .map { [weak self] (devicePackets: [Packet], packetFilter: PacketFilter) -> [Packet] in
                guard let self = self else { return [] }
                if case .date = packetFilter.from {
                    self.hasTimeFilter = true
                } else if case .date = packetFilter.to {
                    self.hasTimeFilter = true
                } else {
                    self.hasTimeFilter = false
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
        print("packets to select: \(identifiers)")
        let action = AppActions.didSelectPackets(identifiers)
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
        print("Trying to export packets: \(appStore.observed.state.selectedPacketIds.count)")
        SavePanel.exportPacketBodies(packets: getSelectedPackets())
    }

    func exportPacketsAndZip() {
        print("Trying to export packets: \(appStore.observed.state.selectedPacketIds.count) and zip")

        SavePanel.exportPacketAsZip(packets: getSelectedPackets())
    }

    func filterUrl(url: String) {
        print("Filtering: \(url)")
        let action = AppActions.didModifiedPacketFilter(PacketFilter(url: url))
        dispatcher.dispatch(action: action)
    }

    func deleteFromLastSelected() {
        guard let first = getSelectedPackets().last,
              let selectedDevice = selectedDevice else { return }
        print("Deleting from first selected packet")
        let action = PacketActions.deleteFrom(first.received, forDeviceId: selectedDevice)
        dispatcher.dispatch(action: action)
    }

    func hideFromLastSelected() {
        guard let first = getSelectedPackets().last else { return }
        print("Hiding from first selected packet")
        let action = AppActions.didModifiedPacketFilter(PacketFilter(from: .date(first.received)))
        dispatcher.dispatch(action: action)
    }

    func deleteCurrentMessages() {
        guard let selectedDevice = selectedDevice else { return }
        print("Hide current messages")
        let action = PacketActions.deleteFrom(Double(Date().timeIntervalSince1970), forDeviceId: selectedDevice)
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

private extension LogViewModel {
    func getSelectedPackets() -> [Packet] {
        let packetIds = appStore.observed.state.selectedPacketIds
        let packets = packetStore.observed.state.projects.allPackets().filter { packet in
            packetIds.contains(packet.id)
        }
        return packets
    }
}

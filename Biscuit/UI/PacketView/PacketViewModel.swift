//
//  PacketViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 06..
//

import Foundation
import AppKit
import Factory
import Combine

protocol PacketViewModelInterface: ObservableObject {
    var selectedPacket: Packet? { get }

    func copyBodyToClipboard(packet: Packet?)
}

class PacketViewModel: PacketViewModelInterface {
    @Injected(BiscuitContainer.appStore) private var appStore
    @Injected(BiscuitContainer.packetStore) private var packetStore
    private var subscriptions: Set<AnyCancellable> = []

    @Published var selectedPacket: Packet?
    
    init() {
        appStore.observed.$state
            .compactMap(\.selectedPacketIds.first)
            .map { [packetStore] packetId in packetStore.observed.state.projects.packetWithId(id: packetId) }
            .sink { [weak self] (packet: Packet?) in
                self?.selectedPacket = packet
            }
            .store(in: &subscriptions)
    }
}

// MARK: - Event handling
extension PacketViewModel {
    func copyBodyToClipboard(packet: Packet?) {
        if let prettyBody = packet?.response.prettyBody {
            let pasteboard = NSPasteboard.general
            pasteboard.declareTypes([.string], owner: nil)
            pasteboard.setString(String(prettyBody), forType: .string)
        }
    }
}

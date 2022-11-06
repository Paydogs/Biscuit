//
//  PacketViewViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 06..
//

import Foundation
import AppKit
import Factory
import Combine

protocol PacketViewViewModelInterface: ObservableObject {
    var selectedPacket: Packet? { get }

    func copyBodyToClipboard(packet: Packet?)
}

class PacketViewViewModel: PacketViewViewModelInterface {
    @Injected(BiscuitContainer.appStore) private var appStore
    private var subscriptions: Set<AnyCancellable> = []

    @Published var selectedPacket: Packet?
    
    init() {
        appStore.observed.$state
            .compactMap(\.selectedPackets.first)
            .sink { [weak self] (packet: Packet) in
                self?.selectedPacket = packet
            }
            .store(in: &subscriptions)
    }
}

// MARK: - Event handling
extension PacketViewViewModel {
    func copyBodyToClipboard(packet: Packet?) {
        if let prettyBody = packet?.response.prettyBody {
            let pasteboard = NSPasteboard.general
            pasteboard.declareTypes([.string], owner: nil)
            pasteboard.setString(String(prettyBody), forType: .string)
        }
    }
}

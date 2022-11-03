//
//  PacketViewController.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 28..
//

import SwiftUI
import Factory
import Combine

protocol PacketViewEventHandling {
    func copyBodyToClipboard(packet: Packet?)
}

class PacketViewController {
    @ObservedObject var domain = PacketViewDomain()

    private let appState: Observed<AppState>
    private let packetState: Observed<PacketState>
    private var subscriptions: Set<AnyCancellable> = []

    init(appState: Observed<AppState>,
         packetState: Observed<PacketState>) {
        self.appState = appState
        self.packetState = packetState

        bind()
    }
}

// MARK: - Data providing
private extension PacketViewController {
    func bind() {
        appState.$state.map(\.selectedPackets.first)
            .sink(receiveValue: { [weak self] value in
                self?.domain.selectedPacket = value
            })
            .store(in: &subscriptions)
    }
}

// MARK: - Event listening
extension PacketViewController: PacketViewEventHandling {
    func copyBodyToClipboard(packet: Packet?) {
        if let prettyBody = packet?.response.prettyBody {
            let pasteboard = NSPasteboard.general
            pasteboard.declareTypes([.string], owner: nil)
            pasteboard.setString(String(prettyBody), forType: .string)
        }
    }
}

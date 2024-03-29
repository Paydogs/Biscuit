//
//  OverviewViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 07..
//

import Foundation
import AppKit
import Factory
import Combine

protocol OverviewViewModelInterface: ObservableObject {
    var selectedPacket: Packet? { get }
    var packetBody: NSAttributedString { get }

    func copyBodyToClipboard(packet: Packet?)
}

class OverviewViewModel: OverviewViewModelInterface {
    @Injected(BiscuitContainer.appStore) private var appStore
    @Injected(BiscuitContainer.packetStore) private var packetStore
    @Injected(BiscuitContainer.postMessageTask) private var postMessageTask
    private var subscriptions: Set<AnyCancellable> = []

    @Published var selectedPacket: Packet?
    @Published var packetBody: NSAttributedString = Localized.packetNothingToShow.withStyle(Style(color: Colors.JSON.unknownColor))

    init() {
        appStore.observed.$state
            .compactMap(\.selectedPacketIds.first)
            .compactMap { [packetStore] packetId in
                return packetStore.observed.state.projects.allPackets().first { packet in
                    packet.id == packetId
                }
            }
            .sink { [weak self] (packet: Packet) in
                self?.selectedPacket = packet
                self?.packetBody = packet.colorizedOverviewDescription
            }
            .store(in: &subscriptions)
    }
}

// MARK: - Event handling
extension OverviewViewModel {
    func copyBodyToClipboard(packet: Packet?) {
        guard let packet = packet else {
            postMessageTask.execute(message: Localized.Messages.CopyToPasteboard.nopacket)
            return
        }
        guard let prettyBody = packet.response.prettyBody else {
            postMessageTask.execute(message: Localized.Messages.CopyToPasteboard.emptybody)
            return
        }
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([.string], owner: nil)
        pasteboard.setString(String(prettyBody), forType: .string)
        postMessageTask.execute(message: Localized.Messages.CopyToPasteboard.success)
    }
}

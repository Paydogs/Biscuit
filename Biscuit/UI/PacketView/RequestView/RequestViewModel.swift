//
//  RequestViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 29..
//

import Foundation
import AppKit
import Factory
import Combine

protocol RequestViewModelInterface: ObservableObject {
    var selectedPacket: Packet? { get }
    var packetBody: NSAttributedString { get }
}

class RequestViewModel: RequestViewModelInterface {
    @Injected(BiscuitContainer.appStore) private var appStore
    @Injected(BiscuitContainer.postMessageTask) private var postMessageTask
    private var subscriptions: Set<AnyCancellable> = []

    @Published var selectedPacket: Packet?
    @Published var packetBody: NSAttributedString = Localized.packetNothingToShow.withStyle(Style(color: Colors.JSON.unknownColor))

    init() {
        appStore.observed.$state
            .compactMap(\.selectedPackets.first)
            .sink { [weak self] (packet: Packet) in
                self?.selectedPacket = packet
                self?.packetBody = packet.colorizedOverviewDescription
            }
            .store(in: &subscriptions)
    }
}

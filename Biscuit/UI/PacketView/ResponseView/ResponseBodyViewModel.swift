//
//  ResponseBodyViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 30..
//

import Foundation
import AppKit
import Factory
import Combine

protocol ResponseBodyViewModelInterface: ObservableObject {
    var selectedPacket: Packet? { get }
    var responseBody: NSAttributedString { get }
}

class ResponseBodyViewModel: ResponseBodyViewModelInterface {
    @Injected(BiscuitContainer.appStore) private var appStore
    @Injected(BiscuitContainer.postMessageTask) private var postMessageTask
    private var subscriptions: Set<AnyCancellable> = []

    @Published var selectedPacket: Packet?
    @Published var responseBody: NSAttributedString = Localized.packetNothingToShow.withStyle(Style(color: Colors.JSON.unknownColor))

    init() {
        appStore.observed.$state
            .compactMap(\.selectedPackets.first)
            .sink { [weak self] (packet: Packet) in
                self?.selectedPacket = packet
                self?.responseBody = packet.colorizedResponseBody
            }
            .store(in: &subscriptions)
    }
}

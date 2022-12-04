//
//  ResponseViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 30..
//

import Foundation
import AppKit
import Factory
import Combine

protocol ResponseViewModelInterface: ObservableObject {
    var selectedPacket: Packet? { get }
    var responseHeaders: [HeaderRow] { get }
    var responseBody: NSAttributedString { get }
}

class ResponseViewModel: ResponseViewModelInterface {
    @Injected(BiscuitContainer.appStore) private var appStore
    @Injected(BiscuitContainer.packetStore) private var packetStore
    @Injected(BiscuitContainer.postMessageTask) private var postMessageTask
    private var subscriptions: Set<AnyCancellable> = []

    @Published var selectedPacket: Packet?
    @Published var responseBody: NSAttributedString = Localized.packetNothingToShow.withStyle(Style(color: Colors.JSON.unknownColor))
    @Published var responseHeaders: [HeaderRow] = []

    init() {
        appStore.observed.$state
            .compactMap(\.selectedPacketIds.first)
            .compactMap { [packetStore] packetId in
                return packetStore.observed.state.projects.allPackets().first { packet in
                    packet.id == packetId
                }
            }
            .sink { [weak self] (packet: Packet) in
                guard let self = self else { return }
                self.selectedPacket = packet
                self.responseHeaders = packet.request.headers.map { (key: String, value: String) in
                    HeaderRow(key: key, value: value)
                }
                self.responseBody = packet.colorizedResponseBody
            }
            .store(in: &subscriptions)
    }
}

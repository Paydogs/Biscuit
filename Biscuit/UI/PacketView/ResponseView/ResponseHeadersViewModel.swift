//
//  ResponseHeadersViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 30..
//

import Foundation
import AppKit
import Factory
import Combine

protocol ResponseHeadersViewModelInterface: ObservableObject {
    var selectedPacket: Packet? { get }
    var responseHeaders: [HeaderRow] { get }
}

class ResponseHeadersViewModel: ResponseHeadersViewModelInterface {
    @Injected(BiscuitContainer.appStore) private var appStore
    @Injected(BiscuitContainer.postMessageTask) private var postMessageTask
    private var subscriptions: Set<AnyCancellable> = []

    @Published var selectedPacket: Packet?
    @Published var responseHeaders: [HeaderRow] = []

    init() {
        appStore.observed.$state
            .compactMap(\.selectedPackets.first)
            .sink { [weak self] (packet: Packet) in
                self?.selectedPacket = packet
                self?.responseHeaders = packet.response.headers.map { (key: String, value: String) in
                    HeaderRow(key: key, value: value)
                }
            }
            .store(in: &subscriptions)
    }
}

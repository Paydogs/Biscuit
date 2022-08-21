//
//  Showcase.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 10..
//

import Foundation
import Combine
import Factory

class Showcase {
    @Injected(BiscuitContainer.packetStore) private var packetStore
    var subscriptions: Set<AnyCancellable> = []

    func startPeaking() {
        subscribePackets()
    }

    func subscribePackets() {
        packetStore.observed.$state.sink { (value: PacketState) in

        }
        .store(in: &subscriptions)
    }
}

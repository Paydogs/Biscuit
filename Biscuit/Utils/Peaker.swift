//
//  Peaker.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 10..
//

import Combine
import Factory

class Peaker {
    @Injected(BiscuitContainer.appStore) private var appStore
    @Injected(BiscuitContainer.packetStore) private var packetStore

    var subscriptions: Set<AnyCancellable> = []

    init() {
        print("[Peaker] initing")
    }

    deinit {
        print("[Peaker] deiniting")
    }

    func startPeaking() {
        packetStore.observed.$state
            .removeDuplicates()
            .sink { (state: PacketState) in
            print("     [Peaker] PacketState changed")
            print("     [Peaker] Project: \(state.projects.count)")
            for project in state.projects {
                print("     [Peaker] Project: \(project.descriptor.name), devices: \(project.devices.count)")
                for device in project.devices {
                    print("     [Peaker] Device: \(device.descriptor.description), packets: \(device.packets.count)")
                    device.packets.forEach { print("     [Peaker] \($0.bagelPacketId) \($0.url)") }
                }
            }
        }
        .store(in: &subscriptions)

        appStore.observed.$state
            .removeDuplicates()
            .sink { (value: AppState) in
                print("[Peaker] Active connections: \(value.connectedClients)")
                print("[Peaker] Selected packets: \(value.selectedPackets.count)")
        }
        .store(in: &subscriptions)
    }
}

//
//  Nosy.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 10..
//

import Combine
import Factory

class Nosy {
    @Injected(BiscuitContainer.appStore) private var appStore
    @Injected(BiscuitContainer.packetStore) private var packetStore

    var subscriptions: Set<AnyCancellable> = []

    init() {
        print("[Nosy] initing")
    }

    deinit {
        print("[Nosy] deiniting")
    }

    func startPeaking() {
        packetStore.observed.$state
            .removeDuplicates()
            .sink { (state: PacketState) in
            print("     [Nosy] PacketState changed")
            print("     [Nosy] Project: \(state.projects.count)")
            for project in state.projects {
                print("     [Nosy] Project: \(project.descriptor.name), devices: \(project.devices.count)")
                for device in project.devices {
                    print("     [Nosy] Device: \(device.descriptor.description), packets: \(device.packets.count)")
                    device.packets.forEach { print("     [Nosy] \($0.bagelPacketId) \($0.url)") }
                }
            }
        }
        .store(in: &subscriptions)

        appStore.observed.$state
            .removeDuplicates()
            .sink { (state: AppState) in
                print("[Nosy] Active connections: \(state.connectedClients)")
                let selectedPackets = state.selectedPackets.map { packet in packet.id }
                print("[Nosy] Selected packets: \(state.selectedPackets.count), \(selectedPackets.joined(separator: ", "))")
                print("[Nosy] Messages: \(state.messages)")
                print("[Nosy] SelectedProject: \(state.buildFilter.project), SelectedDevice: \(state.buildFilter.deviceId)")
                print("[Nosy] Filter: From: \(state.packetFilter.from), To: \(state.packetFilter.to), url: \(state.packetFilter.url)")
        }
        .store(in: &subscriptions)
    }
}

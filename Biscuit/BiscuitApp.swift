//
//  BiscuitApp.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 23..
//

import SwiftUI
import Factory
import Combine

@main
struct BiscuitApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase

    @Injected(BiscuitContainer.appStore) private var appStore
    @Injected(BiscuitContainer.packetStore) private var packetStore
    @Injected(BiscuitContainer.testStore) private var testStore

    var subscriptions: Set<AnyCancellable> = []

    init() {
        peak()
    }

    var body: some Scene {
        WindowGroup {
            MainWindow()
        }
        .onChange(of: scenePhase, perform: { (phase: ScenePhase) in
            switch phase {
                case .background:
                    print("[APP] onBackground")
                case .inactive:
                    print("[APP] onInactive")
                case .active:
                    print("[APP] onActive")
                @unknown default:
                    print("[APP] unknown default")
            }
        })
    }

    mutating func peak() {
        packetStore.$state
            .removeDuplicates()
            .sink { (state: PacketState) in
            print("     [BiscuitApp] PacketState changed")
            print("     [BiscuitApp] Project: \(state.projects.count)")
            for project in state.projects {
                print("     [BiscuitApp] Project: \(project.descriptor.name), devices: \(project.devices.count)")
                for device in project.devices {
                    print("     [BiscuitApp] Device: \(device.descriptor.description), packets: \(device.packets.count)")
                    device.packets.forEach { print("     [BiscuitApp] \($0.bagelPacketId) \($0.url)") }
                }
            }
        }
        .store(in: &subscriptions)

        testStore.$state.sink { (value: TestState) in
            print("New value: \(value.currentValue)")
        }
        .store(in: &subscriptions)
    }
}

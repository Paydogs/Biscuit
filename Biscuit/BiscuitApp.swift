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

    @Injected(BiscuitContainer.packetStore) private var packetStore
    init() { }

    var body: some Scene {
        WindowGroup {
            MainWindow()
                .environmentObject(MainWindowState(packetState: packetStore.observed))
        }
        .onChange(of: scenePhase, perform: { (phase: ScenePhase) in
            switch phase {
                case .background:
                    print("[BiscuitApp] onBackground")
                case .inactive:
                    print("[BiscuitApp] onInactive")
                case .active:
                    print("[BiscuitApp] onActive")
                @unknown default:
                    print("[BiscuitApp] unknown default")
            }
        })
    }
}

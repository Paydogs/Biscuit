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

    init() { }

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
}

//
//  LogController.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 12..
//

import SwiftUI
import Factory
import Combine

class LogController {
    private let appState: Observed<AppState>
    private let packetState: Observed<PacketState>

    @Published var packets: [PacketTableRow] = []

    @State private var deviceSelection: Int = 0

    var subscriptions: Set<AnyCancellable> = []

    init(appState: Observed<AppState>,
         packetState: Observed<PacketState>) {
        self.appState = appState
        self.packetState = packetState
        subscribe()
    }

    func subscribe() {
//        packetState.$state
//            .map(\.projects)
//            .map { projects in
//                projects.sorted().map { $0.descriptor.name }
//            }
//            .assign(to: \.projectList, on: self)
//            .store(in: &subscriptions)
    }
}

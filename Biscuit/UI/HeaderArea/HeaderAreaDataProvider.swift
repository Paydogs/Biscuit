//
//  HeaderAreaDataProvider.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 18..
//

import SwiftUI
import Factory
import Combine

class HeaderAreaDataProvider {
    @ObservedObject var domain: HeaderAreaDomain

    private let appState: Observed<AppState>
    private let packetState: Observed<PacketState>

    private var subscriptions: Set<AnyCancellable> = []

    init(appState: Observed<AppState>,
         packetState: Observed<PacketState>) {
        self.appState = appState
        self.packetState = packetState

        domain =  HeaderAreaDomain()
        subscribe()
    }

    func subscribe() {
        packetState.$state
            .map(\.projects)
            .map { projects in
                projects.sorted().map { $0.descriptor.name }
            }
            .sink(receiveValue: { [weak self] value in
                self?.domain.projectList = value
            })
            .store(in: &subscriptions)

        appState.$state
            .map(\.selectedProject)
            .map { selectedProject in
                guard let selectedProject = selectedProject else { return [] }
                return selectedProject.devices.sorted().map { $0.descriptor.name }
            }
            .sink(receiveValue: { [weak self] value in
                self?.domain.deviceList = value
            })
            .store(in: &subscriptions)
    }
}

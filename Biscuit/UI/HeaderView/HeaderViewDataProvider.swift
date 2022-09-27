//
//  HeaderViewDataProvider.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 18..
//

import SwiftUI
import Factory
import Combine

class HeaderViewDataProvider {
    @ObservedObject var domain: HeaderViewDomain

    private let appState: Observed<AppState>
    private let packetState: Observed<PacketState>

    private var subscriptions: Set<AnyCancellable> = []

    init(appState: Observed<AppState>,
         packetState: Observed<PacketState>) {
        self.appState = appState
        self.packetState = packetState

        domain =  HeaderViewDomain()
        subscribe()
    }

    func subscribe() {
        packetState.$state
            .map(\.projects)
            .map { projects in
                projects.sorted().map { project in
                    StandardPicker.PickerItem(id: project.id, text: project.descriptor.name)
                }
            }
            .sink(receiveValue: { [weak self] value in
                self?.domain.projectList = value
            })
            .store(in: &subscriptions)

        packetState.$state.map(\.projects)
            .combineLatest(appState.$state.map(\.filter))
            .map { (projects: Set<Project>, filter: Filter) in
                projects.filterDevices(filter: filter).map { device in
                    StandardPicker.PickerItem(id: device.id, text: device.descriptor.name)
                }
            }
            .sink(receiveValue: { [weak self] value in
                self?.domain.deviceList = value
            })
            .store(in: &subscriptions)
    }
}

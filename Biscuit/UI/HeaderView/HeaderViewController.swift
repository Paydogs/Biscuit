//
//  HeaderViewController.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 04..
//

import SwiftUI
import Factory
import Combine

protocol HeaderViewEventHandling {
    func projectSelected(identifier: String)
    func deviceSelected(identifier: String)
}

class HeaderViewController {
    @ObservedObject var domain = HeaderViewDomain()

    private let appState: Observed<AppState>
    private let packetState: Observed<PacketState>
    private let updateFilterUseCase: UpdateFilterUseCaseInterface
    private var subscriptions: Set<AnyCancellable> = []

    init(appState: Observed<AppState>,
         packetState: Observed<PacketState>,
         updateFilterUseCase: UpdateFilterUseCaseInterface) {
        self.appState = appState
        self.packetState = packetState
        self.updateFilterUseCase = updateFilterUseCase

        bind()
    }
}

private extension HeaderViewController {
    func bind() {
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

extension HeaderViewController: HeaderViewEventHandling {
    func projectSelected(identifier: String) {
        var filter = Filter(project: identifier)
        print("Picker selected: \(identifier)")
        let devices = packetState.state.projects.filterDevices(filter: filter)
        filter.deviceId = devices.first?.id
        updateFilterUseCase.execute(filter: filter)
    }

    func deviceSelected(identifier: String) {
        print("Device selected: \(identifier)")
        updateFilterUseCase.execute(filter: Filter(deviceId: identifier))
    }
}

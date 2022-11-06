//
//  HeaderViewViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 06..
//

import Foundation
import AppKit
import Factory
import Combine
import SwiftUI

protocol HeaderViewViewModelInterface: ObservableObject {
    var projectList: [StandardPicker.PickerItem]  { get }
    var deviceList: [StandardPicker.PickerItem] { get }

    func projectSelected(identifier: String)
    func deviceSelected(identifier: String)
}

class HeaderViewViewModel: HeaderViewViewModelInterface {
    @Injected(BiscuitContainer.appStore) private var appStore
    @Injected(BiscuitContainer.packetStore) private var packetStore
    @Injected(BiscuitContainer.updateBuildFilterUseCase) private var updateBuildFilterUseCase
    private var subscriptions: Set<AnyCancellable> = []

    @Published var projectList: [StandardPicker.PickerItem] = []
    @Published var deviceList: [StandardPicker.PickerItem] = []

    init() {
        packetStore.observed.$state
            .map(\.projects)
            .map { projects in
                projects.sorted().map { project in
                    StandardPicker.PickerItem(id: project.id, text: project.descriptor.name)
                }
            }
            .sink(receiveValue: { [weak self] value in
                self?.projectList = value
            })
            .store(in: &subscriptions)

        packetStore.observed.$state.map(\.projects)
            .combineLatest(appStore.observed.$state.map(\.buildFilter))
            .map { (projects: Set<Project>, filter: BuildFilter) in
                projects.filterDevices(filter: filter).map { device in
                    StandardPicker.PickerItem(id: device.id, text: device.descriptor.name)
                }
            }
            .sink(receiveValue: { [weak self] value in
                self?.deviceList = value
            })
            .store(in: &subscriptions)
    }
}

// MARK: - Event handling
extension HeaderViewViewModel {
    func projectSelected(identifier: String) {
        var filter = BuildFilter(project: identifier)
        print("Picker selected: \(identifier)")
        let devices = packetStore.observed.state.projects.filterDevices(filter: filter)
        filter.deviceId = devices.first?.id
        updateBuildFilterUseCase.execute(filter: filter)
    }

    func deviceSelected(identifier: String) {
        print("Device selected: \(identifier)")
        updateBuildFilterUseCase.execute(filter: BuildFilter(deviceId: identifier))
    }
}

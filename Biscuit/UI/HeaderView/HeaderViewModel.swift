//
//  HeaderViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 06..
//

import Foundation
import AppKit
import Factory
import Combine
import SwiftUI

protocol HeaderViewModelInterface: ObservableObject {
    var projectList: [StandardPicker.PickerItem]  { get }
    var deviceList: [StandardPicker.PickerItem] { get }

    func projectSelected(identifier: String)
    func deviceSelected(identifier: String)
    func toggleSidebar()
}

class HeaderViewModel: HeaderViewModelInterface {
    @Injected(BiscuitContainer.appStore) private var appStore
    @Injected(BiscuitContainer.packetStore) private var packetStore
    @Injected(BiscuitContainer.dispatcher) private var dispatcher
    private var subscriptions: Set<AnyCancellable> = []

    @Published var projectList: [StandardPicker.PickerItem] = []
    @Published var deviceList: [StandardPicker.PickerItem] = []

    init() {
        packetStore.observed.$state
            .map(\.projects)
            .map { projects in
                projects.map { project in
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
                return projects.devices(filter: filter).map { device in
                    let icon = device.online ? "iphone" : "iphone.slash"
                    return StandardPicker.PickerItem(id: device.id, text: device.descriptor.name, icon: icon)
                }
            }
            .sink(receiveValue: { [weak self] value in
                self?.deviceList = value
            })
            .store(in: &subscriptions)
    }
}

// MARK: - Event handling
extension HeaderViewModel {
    func projectSelected(identifier: String) {
        var filter = BuildFilter(project: identifier)
        print("Picker selected: \(identifier)")
        let devices = packetStore.observed.state.projects.devices(filter: filter)
        filter.deviceId = devices.first?.id
        let action = AppActions.didModifiedBuildFilter(filter)
        dispatcher.dispatch(action: action)
    }

    func deviceSelected(identifier: String) {
        print("Device selected: \(identifier)")
        let action = AppActions.didModifiedBuildFilter(BuildFilter(deviceId: identifier))
        dispatcher.dispatch(action: action)
    }

    func toggleSidebar() {
        dispatcher.dispatch(action: AppActions.toggleSidebar)
    }
}

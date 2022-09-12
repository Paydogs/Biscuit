//
//  HeaderController.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 04..
//

import SwiftUI
import Factory
import Combine

class HeaderController {
    private let appState: Observed<AppState>
    private let packetState: Observed<PacketState>
    private let selectProjectUseCase: SelectProjectUseCaseInterface
    private let selectDeviceUseCase: SelectDeviceUseCaseInterface

    @Published var projectList: [String] = []
    @Published var deviceList: [String] = []

    @State private var deviceSelection: Int = 0

    var subscriptions: Set<AnyCancellable> = []

    init(appState: Observed<AppState>,
         packetState: Observed<PacketState>,
         selectProjectUseCase: SelectProjectUseCaseInterface,
         selectDeviceUseCase: SelectDeviceUseCaseInterface) {
        self.appState = appState
        self.packetState = packetState
        self.selectProjectUseCase = selectProjectUseCase
        self.selectDeviceUseCase = selectDeviceUseCase
        subscribe()
    }

    func subscribe() {
        packetState.$state
            .map(\.projects)
            .map { projects in
                projects.sorted().map { $0.descriptor.name }
            }
            .assign(to: \.projectList, on: self)
            .store(in: &subscriptions)

        appState.$state
            .map(\.selectedProject)
            .map { selectedProject in
                guard let selectedProject = selectedProject else { return [] }
                return selectedProject.devices.sorted().map { $0.descriptor.name }
            }
            .assign(to: &$deviceList)
    }

    func projectSelected(index: Int) {
        print("Picker selected: \(index)")
        let project = packetState.state.projects.sorted()[index]
        print("Selected project: \(project)")
        selectProjectUseCase.execute(project: project)
    }

    func deviceSelected(index: Int) {
        print("Device selected: \(index)")
        let devices = appState.state.selectedProject?.devices.sorted()
        if let device = devices?[index] {
            selectDeviceUseCase.execute(device: device)
        }
    }
}

//
//  HeaderAreaEventHandler.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 18..
//

protocol HeaderAreaEventHandling {
    func projectSelected(index: Int)
    func deviceSelected(index: Int)
}

struct HeaderAreaEventHandler {
    private let appState: Observed<AppState>
    private let packetState: Observed<PacketState>
    private let selectProjectUseCase: SelectProjectUseCaseInterface
    private let selectDeviceUseCase: SelectDeviceUseCaseInterface

    init(appState: Observed<AppState>,
         packetState: Observed<PacketState>,
         selectProjectUseCase: SelectProjectUseCaseInterface,
         selectDeviceUseCase: SelectDeviceUseCaseInterface) {
        self.appState = appState
        self.packetState = packetState
        self.selectProjectUseCase = selectProjectUseCase
        self.selectDeviceUseCase = selectDeviceUseCase
    }
}

extension HeaderAreaEventHandler: HeaderAreaEventHandling {
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

//
//  HeaderViewEventHandler.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 18..
//

protocol HeaderViewEventHandling {
    func projectSelected(identifier: String)
    func deviceSelected(identifier: String)
}

struct HeaderViewEventHandler {
    private let appState: Observed<AppState>
    private let packetState: Observed<PacketState>
    private let selectProjectUseCase: SelectProjectUseCaseInterface
    private let selectDeviceUseCase: SelectDeviceUseCaseInterface
    private let updateFilterUseCase: UpdateFilterUseCaseInterface

    init(appState: Observed<AppState>,
         packetState: Observed<PacketState>,
         selectProjectUseCase: SelectProjectUseCaseInterface,
         selectDeviceUseCase: SelectDeviceUseCaseInterface,
         updateFilterUseCase: UpdateFilterUseCaseInterface) {
        self.appState = appState
        self.packetState = packetState
        self.selectProjectUseCase = selectProjectUseCase
        self.selectDeviceUseCase = selectDeviceUseCase
        self.updateFilterUseCase = updateFilterUseCase
    }
}

extension HeaderViewEventHandler: HeaderViewEventHandling {
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

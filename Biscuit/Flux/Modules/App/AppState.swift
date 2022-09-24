//
//  AppState.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 11..
//

struct AppState: FluxState {
    var connectedClients: [Client]
    var errors: [AppError]
    var invalidPackets: [InvalidPacket]
    var selectedProject: Project?
    var selectedDevice: Device?
    var filter: Filter
}

extension AppState: DefaultInitializer {
    static func defaultValue() -> AppState {
        return .init(connectedClients: [],
                     errors: [],
                     invalidPackets: [],
                     filter: Filter())
    }
}

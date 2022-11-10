//
//  AppState.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 11..
//

struct AppState: FluxState {
    var connectedClients: [Client]
    var errors: [AppError]
    var messages: [String]
    var invalidPackets: [InvalidPacket]
    var selectedProject: Project?
    var selectedDevice: Device?
    var selectedPackets: [Packet]
    var buildFilter: BuildFilter
    var packetFilter: PacketFilter
}

extension AppState: DefaultInitializer {
    static func defaultValue() -> AppState {
        return .init(connectedClients: [],
                     errors: [],
                     messages: [],
                     invalidPackets: [],
                     selectedPackets: [],
                     buildFilter: BuildFilter(),
                     packetFilter: PacketFilter())
    }
}

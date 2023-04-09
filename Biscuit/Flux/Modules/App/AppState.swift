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
    var selectedPacketIds: [String]
    var buildFilter: AppFilter
    var packetFilter: PacketFilter
    var isSidebarOpen: Bool
}

extension AppState: DefaultInitializer {
    static func defaultValue() -> AppState {
        return .init(connectedClients: [],
                     errors: [],
                     messages: [],
                     selectedPacketIds: [],
                     buildFilter: AppFilter(),
                     packetFilter: PacketFilter(),
                     isSidebarOpen: true)
    }
}

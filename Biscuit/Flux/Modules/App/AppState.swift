//
//  AppState.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 11..
//

struct AppState: FluxState {
    var connectedClients: [Client]
    var errors: [AppError]
}

extension AppState: DefaultInitializer {
    static func defaultValue() -> AppState {
        return .init(connectedClients: [],
                     errors: [])
    }
}

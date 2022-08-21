//
//  AppState.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 11..
//

struct AppState: FluxState {
    var activeConnections: Int
    var errors: [AppError]
}

extension AppState: DefaultInitializer {
    static func defaultValue() -> AppState {
        return .init(activeConnections: 0,
                     errors: [])
    }
}

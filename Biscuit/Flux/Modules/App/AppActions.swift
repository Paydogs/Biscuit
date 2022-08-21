//
//  AppActions.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 11..
//

enum AppActions: FluxAction {
    case setActiveConnectionCount(Int)
    case didReceivedErrors([AppError])
}

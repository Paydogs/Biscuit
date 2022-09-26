//
//  AppActions.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 11..
//

enum AppActions: FluxAction {
    case didConnectClient(Client)
    case didDisconnectClient(Client)
    case didReceivedErrors([AppError])
    case didReceivedInvalidPacket(InvalidPacket)
    case didSelectPackets([Packet])
    case didModifiedFilter(Filter)
}

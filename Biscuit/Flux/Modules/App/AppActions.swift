//
//  AppActions.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 11..
//

enum AppActions: FluxAction {
    case didConnectClient(Client)
    case didDisconnectClientId(String)
    case didReceivedErrors([AppError])
    case didSendMessage(String)
    case didRemoveLastMessage
    case didSelectPackets([String])
    case didModifiedBuildFilter(AppFilter)
    case didModifiedPacketFilter(PacketFilter)
    case didResetPacketFilter
    case toggleSidebar
}

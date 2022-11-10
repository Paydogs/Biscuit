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
    case didSendMessage(String)
    case didRemoveLastMessage
    case didReceivedInvalidPacket(InvalidPacket)
    case didSelectPackets([Packet])
    case didModifiedBuildFilter(BuildFilter)
    case didModifiedPacketFilter(PacketFilter)
    case didResetPacketFilter
}

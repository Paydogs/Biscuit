//
//  PacketActions.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 20..
//

enum PacketActions: FluxAction {
    case didStorePacket(IncomingPacket)
    case didClientWentOffline(Client)
    case didTogglePacketPinStatus([String])
}

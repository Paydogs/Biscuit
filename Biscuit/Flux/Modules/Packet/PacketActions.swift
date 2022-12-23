//
//  PacketActions.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 20..
//

enum PacketActions: FluxAction {
    case didStorePacket(IncomingPacket)
    case didReceivedInvalidPacket(InvalidPacket)
    case didClientWentOffline(Client)
    case didTogglePacketPinStatus([String])
    case didSetPacketPinStatusOn([String])
    case didSetPacketPinStatusOff([String])
    case deleteFrom(Double, forDeviceId: String)
    case deleteOfflineDevices
}

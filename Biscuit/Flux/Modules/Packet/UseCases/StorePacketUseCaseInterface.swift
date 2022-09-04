//
//  StorePacketUseCaseInterface.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 20..
//

protocol StorePacketUseCaseInterface {
    func execute(packet: IncomingPacket)
}

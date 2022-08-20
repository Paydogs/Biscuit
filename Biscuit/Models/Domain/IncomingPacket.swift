//
//  IncomingPacket.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 20..
//

import Foundation

struct IncomingPacket {
    let project: ProjectDescriptor
    let device: DeviceDescriptor
    let packet: Packet
}

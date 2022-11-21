//
//  IncomingPacket.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 20..
//

import Foundation

struct IncomingPacket {
    let projectDescriptor: ProjectDescriptor
    let deviceDescriptor: DeviceDescriptor
    let packet: Packet
}

//
//  DescriptionUtils.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 20..
//

import Foundation

extension Array where Element == Project {
    func describe() {
        self.forEach { project in project.describe() }
    }
}

extension Project {
    func describe() {
        print("[DESCRIPTION][PROJECT] \(self.descriptor.name), devices: \(self.devices.count)")
        self.devices.forEach { device in device.describe() }
    }
}

extension Device {
    func describe() {
        print("[DESCRIPTION][PROJECT][DEVICE] \(self.descriptor.name), deviceID: \(self.id), packets: \(self.packets.count), online: \(self.descriptor.online)")
        self.packets.forEach { packet in packet.describe() }
    }
}

extension Packet {
    func describe() {
        print("[DESCRIPTION][PROJECT][DEVICE][PACKET] \(self.bagelPacketId), \(self.url)")
    }
}

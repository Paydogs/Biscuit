//
//  Device.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 20..
//

struct Device: Identifiable {
    var descriptor: DeviceDescriptor
    var packets: Set<Packet>
    var id: String {
        descriptor.deviceId
    }
}

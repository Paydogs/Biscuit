//
//  Collection+Utils.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 22..
//

extension Collection where Element == Project {
    func sorted() -> [Project] {
        return self.sorted { (lhs:Project, rhs: Project) in
            lhs.descriptor.name < rhs.descriptor.name
        }
    }

    func allPackets() -> [Packet] {
        return self.map(\.devices).flatMap { (devices: Set<Device>) -> [Packet] in
            return devices.flatMap { (device: Device) -> [Packet] in return Array(device.packets) }
        }
    }
}

extension Collection where Element == Device {
    func sorted() -> [Device] {
        return self.sorted { (lhs:Device, rhs: Device) in
            lhs.descriptor.name < rhs.descriptor.name
        }
    }
}

extension Collection where Element == Packet {
    func sorted() -> [Packet] {
        return self.sorted { (lhs:Packet, rhs: Packet) in
            lhs.received < rhs.received
        }
    }
}

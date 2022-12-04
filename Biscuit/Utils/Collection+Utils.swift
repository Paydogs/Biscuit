//
//  Collection+Utils.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 22..
//

extension Collection where Element == Project {
    /// Sorts a collection of Projects by their name
    func sorted() -> [Project] {
        return self.sorted { (lhs:Project, rhs: Project) in
            lhs.descriptor.name < rhs.descriptor.name
        }
    }

    /// Get all packets in all the devices in the project
    func allPackets() -> [Packet] {
        return self.map(\.devices).flatMap { (devices: Set<Device>) -> [Packet] in
            return devices.flatMap { (device: Device) -> [Packet] in return Array(device.packets) }
        }
    }

    /// Get every id of the devices in the project
    func deviceIds() -> [String] {
        return self.flatMap { project in project.devices.map(\.id) }
    }
}

extension Collection where Element == Device {
    /// Sorts a collection of Devices by their id
    func sorted() -> [Device] {
        return self.sorted { (lhs:Device, rhs: Device) in
            lhs.descriptor.deviceId < rhs.descriptor.deviceId
        }
    }
}

extension Collection where Element == Packet {
    func sorted() -> [Packet] {
        /// Sorts a collection of Devices by received time (in double)
        return self.sorted { (lhs:Packet, rhs: Packet) in
            lhs.received < rhs.received
        }
    }
}

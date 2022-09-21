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

    func filterDevices(filter: Filter) -> [Device] {
        guard let project = self.first(where: { project in project.id == filter.project }) else { return [] }
        return project.devices.sorted()
    }

    func filterPackets(filter: Filter) -> [Packet] {
        guard let device = self.filterDevices(filter: filter).first(where: { device in device.id == filter.deviceId }) else { return [] }
        return device.packets.filteredPackets(filter: filter)
    }
}

extension Collection where Element == Device {
    func sorted() -> [Device] {
        return self.sorted { (lhs:Device, rhs: Device) in
            lhs.descriptor.name < rhs.descriptor.name
        }
    }

    func filterPackets(filter: Filter) -> [Packet] {
        guard let device = self.first(where: { device in device.id == filter.deviceId }) else { return [] }
        return device.packets.filteredPackets(filter: filter)
    }
}

extension Collection where Element == Packet {
    func sorted() -> [Packet] {
        return self.sorted { (lhs:Packet, rhs: Packet) in
            lhs.startDate < rhs.startDate
        }
    }

    func filteredPackets(filter: Filter) -> [Packet] {
        return self.compactMap { packet -> Packet? in
            if let fromDate = filter.from, packet.startDate < fromDate { return nil }
            if let toDate = filter.to, packet.startDate > toDate { return nil }
            return packet
        }.sorted { (lhs:Packet, rhs: Packet) in
            lhs.startDate < rhs.startDate
        }
    }
}

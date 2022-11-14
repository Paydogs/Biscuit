//
//  Collection+Filter.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 07..
//

extension Set where Element == Project {
    func devices(filter: BuildFilter) -> Set<Device> {
        guard let project = self.first(where: { project in project.id == filter.project }) else { return [] }
        return project.devices
    }
    func packetsOfDeviceInFilter(filter: BuildFilter) -> Set<Packet> {
        let devices = devices(filter: filter)
        let selectedDevice = devices.first { device in
            device.id == filter.deviceId
        }
        return selectedDevice?.packets ?? []
    }
}

extension Set where Element == Device {
    func packetsOfSelectedDevice(filter: BuildFilter) -> Set<Packet> {
        guard let device = self.first(where: { device in device.id == filter.deviceId }) else { return [] }
        return device.packets
    }
}

extension Collection where Element == Packet {
    func filteredPackets(filter: PacketFilter) -> [Packet] {
        return self.compactMap { packet -> Packet? in
            if case let .date(fromDate) = filter.from, packet.received < fromDate { return nil }
            if case let .date(toDate) = filter.to, packet.received > toDate { return nil }
            if let statusCode = filter.statusCode, packet.statusCode != statusCode { return nil }
            if let url = filter.url, !url.isEmpty, !packet.url.contains(url) { return nil }
            return packet
        }.sorted { (lhs:Packet, rhs: Packet) in
            lhs.startDate < rhs.startDate
        }
    }
}

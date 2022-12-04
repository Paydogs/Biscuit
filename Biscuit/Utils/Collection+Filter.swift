//
//  Collection+Filter.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 07..
//

extension Set where Element == Project {
    /// Returns a collection of devices of the project, filtered by the contents of the BuildFilter
    func devicesOfProjectInFilter(filter: BuildFilter) -> Set<Device> {
        guard let project = self.first(where: { project in project.id == filter.project }) else { return [] }
        return project.devices
    }
    /// Returns a collection of packets of the project, filtered by the contents of the BuildFilter
    func packetsOfDeviceInFilter(filter: BuildFilter) -> Set<Packet> {
        let devices = devicesOfProjectInFilter(filter: filter)
        let selectedDevice = devices.first { device in
            device.id == filter.deviceId
        }
        return selectedDevice?.packets ?? []
    }
}

extension Set where Element == Device {
    /// Returns a collection of packets of the devices, filtered by the contents of the BuildFilter
    func packetsOfSelectedDevice(filter: BuildFilter) -> Set<Packet> {
        guard let device = self.first(where: { device in device.id == filter.deviceId }) else { return [] }
        return device.packets
    }
}

extension Collection where Element == Packet {
    /// Filters packets by the contents of the PacketFilter
    /// Pinned packets are not filtered out
    /// The remaining packets, which were not filtered out, will be sorted by received time (double)
    func filteredPackets(filter: PacketFilter) -> [Packet] {
        return self.compactMap { packet -> Packet? in
            if let url = filter.url, !url.isEmpty, !packet.url.contains(url) { return nil }
            if packet.pinned { return packet }
            if case let .date(fromDate) = filter.from, packet.received < fromDate { return nil }
            if case let .date(toDate) = filter.to, packet.received > toDate { return nil }
            if let statusCode = filter.statusCode, packet.statusCode != statusCode { return nil }
            return packet
        }.sorted { (lhs:Packet, rhs: Packet) in
            lhs.received < rhs.received
        }
    }
}

//
//  Collection+Filter.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 07..
//

extension Collection where Element == Project {
    func filterDevices(filter: BuildFilter) -> [Device] {
        guard let project = self.first(where: { project in project.id == filter.project }) else { return [] }
        return project.devices.sorted()
    }
}

extension Collection where Element == Packet {
    func filteredPackets(filter: PacketFilter) -> [Packet] {
        return self.compactMap { packet -> Packet? in
            if let fromDate = filter.from, packet.startDate < fromDate { return nil }
            if let toDate = filter.to, packet.startDate > toDate { return nil }
            if let statusCode = filter.statusCode, packet.statusCode != statusCode { return nil }
            if let url = filter.url, !url.isEmpty, !packet.url.contains(url) { return nil }
            return packet
        }.sorted { (lhs:Packet, rhs: Packet) in
            lhs.startDate < rhs.startDate
        }
    }
}

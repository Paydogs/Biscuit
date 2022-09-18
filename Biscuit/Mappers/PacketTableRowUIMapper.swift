//
//  PacketTableRowUIMapper.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 28..
//

struct PacketTableRowUIMapper {
    static func getPacketRows(list: Set<Packet>?) -> [PacketTableRow] {
        guard let list = list else { return [] }
        return list.enumerated().map { (index, packet: Packet) -> PacketTableRow in
            return .init(id: packet.bagelPacketId, status: packet.statusCode, method: packet.request.method?.rawValue ?? "", url: packet.url, date: packet.startDate.description)
        }
    }
}

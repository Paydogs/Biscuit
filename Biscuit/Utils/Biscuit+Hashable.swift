//
//  Biscuit+Hashable.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 20..
//

extension Device: Equatable, Hashable {
    static func == (lhs: Device, rhs: Device) -> Bool {
        lhs.descriptor == rhs.descriptor
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(descriptor)
    }
}

extension Project: Equatable, Hashable {
    static func == (lhs: Project, rhs: Project) -> Bool {
        lhs.descriptor == rhs.descriptor
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(descriptor)
    }
}

extension Packet: Equatable, Hashable {
    static func == (lhs: Packet, rhs: Packet) -> Bool {
        lhs.bagelPacketId == rhs.bagelPacketId
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(bagelPacketId)
    }
}

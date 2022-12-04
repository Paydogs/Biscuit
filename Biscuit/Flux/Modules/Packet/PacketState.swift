//
//  PacketState.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 20..
//

struct PacketState: FluxState {
    var projects: Set<Project>
    var invalidPackets: [InvalidPacket]
}

extension PacketState: DefaultInitializer {
    static func defaultValue() -> PacketState {
        return .init(projects: [],
                     invalidPackets: [])
    }
}

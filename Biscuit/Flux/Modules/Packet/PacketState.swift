//
//  PacketState.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 20..
//

struct PacketState: State, Equatable {
    var projects: Set<Project>
}

extension PacketState: DefaultInitializer {
    static func defaultValue() -> PacketState {
        return .init(projects: [])
    }
}

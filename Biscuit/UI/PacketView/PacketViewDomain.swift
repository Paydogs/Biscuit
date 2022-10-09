//
//  PacketViewDomain.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 28..
//

import Combine

class PacketViewDomain: ObservableObject {
    @Published var selectedPacket: Packet?
}

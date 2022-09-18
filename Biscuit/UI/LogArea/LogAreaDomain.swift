//
//  LogAreaDomain.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 18..
//

import Combine

class LogAreaDomain: ObservableObject {
    @Published var packets: [PacketTableRow] = []
}

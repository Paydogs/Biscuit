//
//  LogViewDomain.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 18..
//

import Combine

class LogViewDomain: ObservableObject {
    @Published var packets: [PacketTableRow] = []
}

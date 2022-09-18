//
//  PacketTableRow.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 28..
//

import Foundation

struct PacketTableRow: Identifiable {
    let id: String
    let status: String
    var method: String
    var url: String
    var date: String
}

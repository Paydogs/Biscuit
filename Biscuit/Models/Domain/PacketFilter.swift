//
//  PacketFilter.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 06..
//

import Foundation

struct PacketFilter: Equatable {
    var from: Date?
    var to: Date?
    var statusCode: StatusCode?
    var url: String?
}

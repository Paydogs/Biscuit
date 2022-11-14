//
//  PacketFilter.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 06..
//

import Foundation

struct PacketFilter: Equatable {
    var from: DateReference = .unmodified
    var to: DateReference = .unmodified
    var statusCode: StatusCode?
    var url: String?
}

extension PacketFilter {
    enum DateReference: Equatable {
        case unmodified
        case date(Double)
        case reset
    }
}

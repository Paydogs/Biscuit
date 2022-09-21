//
//  Packet.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 20..
//

import Foundation

struct Packet: Identifiable {
    let bagelPacketId: String

    let url: String
    let statusCode: String
    let startDate: Date
    let endDate: Date

    let request: Request
    let response: Response

    var id: String {
        bagelPacketId
    }
}

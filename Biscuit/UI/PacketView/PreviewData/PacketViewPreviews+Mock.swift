//
//  PacketViewPreviews+Mock.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 28..
//

import Foundation

extension PacketView_Previews {
    func createDummyPacket() -> Packet {
        return .init(bagelPacketId: "",
                     received: 0,
                     url: "",
                     statusCode: .init(code: 999),
                     startDate: Date.now,
                     endDate: Date.now,
                     request: Request.defaultValue(),
                     response: Response.defaultValue())
    }
    struct DummyHandler: PacketViewEventHandling {
        func copyBodyToClipboard(packet: Packet?) { }
    }

    static func createDummyDomain() -> PacketViewDomain {
        let domain = PacketViewDomain()
        return domain
    }
}

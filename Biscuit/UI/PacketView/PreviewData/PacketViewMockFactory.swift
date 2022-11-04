//
//  PacketViewMockFactory.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 28..
//

import Foundation

struct PacketViewMockFactory {
    static func createDummyDomain() -> PacketViewDomain {
        let domain = PacketViewDomain()
        domain.selectedPacket = .init(bagelPacketId: "",
                                      received: 0,
                                      url: "",
                                      statusCode: .init(code: 999),
                                      startDate: Date.now,
                                      endDate: Date.now,
                                      request: Request.defaultValue(),
                                      response: Response.defaultValue())
        return domain
    }

    static func createDummyHandler() -> PacketViewEventHandling {
        return DummyHandler()
    }
}

private extension PacketViewMockFactory {
    struct DummyHandler: PacketViewEventHandling {
        func copyBodyToClipboard(packet: Packet?) { }
    }
}

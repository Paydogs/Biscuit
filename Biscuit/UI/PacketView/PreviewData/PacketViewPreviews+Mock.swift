//
//  PacketViewPreviews+Mock.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 28..
//

import Foundation

extension PacketView_Previews {
    struct DummyHandler: PacketViewEventHandling {

    }

    static func createDummyDomain() -> PacketViewDomain {
        let domain = PacketViewDomain()
        return domain
    }
}

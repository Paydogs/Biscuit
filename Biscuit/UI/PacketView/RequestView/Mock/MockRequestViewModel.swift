//
//  MockRequestViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 29..
//

import AppKit

class MockRequestViewModel: RequestViewModelInterface {
    var selectedPacket: Packet? = DummyObjectLibrary.createPacketSimpleBody()
    var packetBody: NSAttributedString = DummyObjectLibrary.createPacketSimpleBody().colorizedOverviewDescription
}

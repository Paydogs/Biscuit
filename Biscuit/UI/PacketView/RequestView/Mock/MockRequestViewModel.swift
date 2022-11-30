//
//  MockRequestViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 29..
//

import AppKit

class MockRequestViewModel: RequestViewModelInterface {
    var selectedPacket: Packet? = DummyObjectLibrary.createPacketSimpleBody()
    var requestHeaders: [HeaderRow] = [HeaderRow(key: "Key 1", value: "Value 1"),
                                       HeaderRow(key: "Key 2", value: "Value 2"),
                                       HeaderRow(key: "Key 3", value: "Value 3"),
                                       HeaderRow(key: "Key 4", value: "Value 4"),
                                       HeaderRow(key: "Key 5", value: "Value 5")]
    var requestBody: NSAttributedString = DummyObjectLibrary.createPacketSimpleBody().colorizedRequestBody
}

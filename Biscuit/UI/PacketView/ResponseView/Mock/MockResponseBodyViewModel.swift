//
//  MockResponseViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 29..
//

import AppKit

class MockResponseBodyViewModel: ResponseBodyViewModelInterface {
    var selectedPacket: Packet? = DummyObjectLibrary.createPacketSimpleBody()
    var responseBody: NSAttributedString = DummyObjectLibrary.createPacketSimpleBody().colorizedResponseBody
}

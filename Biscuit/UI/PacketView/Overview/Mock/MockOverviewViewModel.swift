//
//  MockOverviewViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 07..
//
import AppKit

class MockOverviewViewModel: OverviewViewModelInterface {
    var selectedPacket: Packet? = DummyObjectLibrary.createPacketSimpleBody()
    var packetBody: NSAttributedString = DummyObjectLibrary.createPacketSimpleBody().colorizedOverviewDescription

    func copyBodyToClipboard(packet: Packet?) { }
}

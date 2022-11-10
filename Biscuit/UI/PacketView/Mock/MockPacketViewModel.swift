//
//  MockPacketViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 06..
//

class MockPacketViewModel: PacketViewModelInterface {
    var selectedPacket: Packet? = DummyObjectLibrary.createPacketSimpleBody()

    func copyBodyToClipboard(packet: Packet?) { }
}

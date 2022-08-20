//
//  StorePacketUseCase.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 20..
//

import Factory

struct StorePacketUseCase: StorePacketUseCaseInterface {
    @Injected(BiscuitContainer.dispatcher) private var dispatcher

    func execute(packet: IncomingPacket) {
        print("[StorePacketUseCase] sending action")
        let action: PacketActions = .storePacket(packet)
        dispatcher.dispatch(action: action)
    }
}

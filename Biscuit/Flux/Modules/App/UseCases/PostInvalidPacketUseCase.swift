//
//  PostInvalidPacketUseCase.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 24..
//

import Factory

struct PostInvalidPacketUseCase: PostInvalidPacketUseCaseInterface {
    @Injected(BiscuitContainer.dispatcher) private var dispatcher

    func execute(packet: InvalidPacket) {
        print("[PostInvalidPacketUseCase] sending action")
        let action: AppActions = .didReceivedInvalidPacket(packet)
        dispatcher.dispatch(action: action)
    }
}

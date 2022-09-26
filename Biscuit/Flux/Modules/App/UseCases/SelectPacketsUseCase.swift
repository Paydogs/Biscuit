//
//  SelectPacketsUseCase.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 25..
//

import Factory

struct SelectPacketsUseCase: SelectPacketsUseCaseInterface {
    @Injected(BiscuitContainer.dispatcher) private var dispatcher

    func execute(packets: [Packet]) {
        print("[SelectPacketsUseCase] sending action")
        let action: AppActions = .didSelectPackets(packets)
        dispatcher.dispatch(action: action)
    }
}

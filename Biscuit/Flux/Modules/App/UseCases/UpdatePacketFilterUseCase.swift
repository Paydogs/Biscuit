//
//  UpdatePacketFilterUseCase.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 06..
//

import Factory

struct UpdatePacketFilterUseCase: UpdatePacketFilterUseCaseInterface {
    @Injected(BiscuitContainer.dispatcher) private var dispatcher

    func execute(filter: PacketFilter) {
        print("[UpdatePacketFilterUseCase] sending action")
        let action: AppActions = .didModifiedPacketFilter(filter)
        dispatcher.dispatch(action: action)
    }
}

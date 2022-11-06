//
//  ResetPacketFilterUseCase.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 06..
//

import Factory

struct ResetPacketFilterUseCase: ResetPacketFilterUseCaseInterface {
    @Injected(BiscuitContainer.dispatcher) private var dispatcher

    func execute() {
        print("[ResetPacketFilterUseCase] sending action")
        let action: AppActions = .didResetPacketFilter
        dispatcher.dispatch(action: action)
    }
}

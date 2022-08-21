//
//  SetActiveConnectionCountUseCase.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 21..
//

import Factory

struct SetActiveConnectionCountUseCase: SetActiveConnectionCountUseCaseInterface {
    @Injected(BiscuitContainer.dispatcher) private var dispatcher

    func execute(count: Int) {
        print("[SetActiveConnectionCountUseCase] sending action")
        let action: AppActions = .setActiveConnectionCount(count)
        dispatcher.dispatch(action: action)
    }
}

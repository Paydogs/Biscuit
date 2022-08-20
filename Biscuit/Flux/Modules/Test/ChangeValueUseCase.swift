//
//  ChangeValueUseCase.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 13..
//

import Factory

struct ChangeValueUseCase: ChangeValueUseCaseInterface {
    @Injected(BiscuitContainer.dispatcher) private var dispatcher

    func execute(amount: Int) {
        print("[ChangeValueUseCase] sending action")
        let action: TestActions = .modifyValue(amount)
        dispatcher.dispatch(action: action)
    }
}

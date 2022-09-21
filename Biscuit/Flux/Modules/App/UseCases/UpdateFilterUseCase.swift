//
//  UpdateFilterUseCase.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 18..
//

import Factory

struct UpdateFilterUseCase: UpdateFilterUseCaseInterface {
    @Injected(BiscuitContainer.dispatcher) private var dispatcher

    func execute(filter: Filter) {
        print("[UpdateFilterUseCase] sending action")
        let action: AppActions = .didModifiedFilter(filter)
        dispatcher.dispatch(action: action)
    }
}

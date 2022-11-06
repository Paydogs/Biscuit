//
//  UpdateBuildFilterUseCase.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 18..
//

import Factory

struct UpdateBuildFilterUseCase: UpdateBuildFilterUseCaseInterface {
    @Injected(BiscuitContainer.dispatcher) private var dispatcher

    func execute(filter: BuildFilter) {
        print("[UpdateBuildFilterUseCase] sending action")
        let action: AppActions = .didModifiedBuildFilter(filter)
        dispatcher.dispatch(action: action)
    }
}

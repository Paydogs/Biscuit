//
//  SelectProjectUseCase.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 04..
//

import Factory

struct SelectProjectUseCase: SelectProjectUseCaseInterface {
    @Injected(BiscuitContainer.dispatcher) private var dispatcher

    func execute(project: Project?) {
        print("[SelectProjectUseCase] sending action")
        let action: AppActions = .didSelectProject(project)
        dispatcher.dispatch(action: action)
    }
}

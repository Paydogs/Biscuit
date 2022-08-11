//
//  PostAppErrorUseCase.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 12..
//

import Factory

struct PostAppErrorUseCase: PostAppErrorUseCaseInterface {
    @Injected(BiscuitContainer.dispatcher) private var dispatcher

    func execute(errors: [AppError]) {
        print("[PostAppErrorUseCase] sending action")
        let action: AppActions = .didReceivedErrors(errors)
        dispatcher.dispatch(action: action)
    }
}

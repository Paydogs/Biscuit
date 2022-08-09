//
//  PostMessageUseCase.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 03..
//

import Factory

struct PostMessageUseCase: PostMessageUseCaseInterface {
    @Injected(BiscuitContainer.dispatcher) private var dispatcher

    func execute(message: Message) {
        print("[PostMessageUseCase] sending action")
        let action: MessageActions = .didReceivedMessage(message)
        dispatcher.dispatch(action: action)
    }
}

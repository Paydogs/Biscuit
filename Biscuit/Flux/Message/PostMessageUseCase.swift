//
//  PostMessageUseCase.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 03..
//

import Factory

extension Container {
    static let postMessageUseCase = Factory { PostMessageUseCase() as PostMessageUseCaseInterface }
}

struct PostMessageUseCase: PostMessageUseCaseInterface {
    @Injected(Container.dispatcher) private var dispatcher

    func execute(message: Message) {
        let action: MessageActions = .didReceivedMessage(message)
        dispatcher.dispatch(action: action)
    }
}

//
//  PostMessageUseCase.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 10..
//

import Factory
import Foundation

struct PostMessageUseCase: PostMessageUseCaseInterface {
    @Injected(BiscuitContainer.dispatcher) private var dispatcher

    func execute(message: String) {
        execute(message: message, duration: 1.5)
    }

    func execute(message: String, duration: Double) {
        print("[PostMessageUseCase] sending action")
        let action: AppActions = .didSendMessage(message)
        dispatcher.dispatch(action: action)

        DispatchQueue.main.asyncAfter(deadline: .now() + (duration)) {
            let action: AppActions = .didRemoveLastMessage
            dispatcher.dispatch(action: action)
        }
    }
}

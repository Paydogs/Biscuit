//
//  PostMessageUseCase.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 03..
//

import Foundation

struct PostMessageUseCase {
    func execute(message: Message) {
        let action: MessageActions = .didReceivedMessage(message)
    }
}

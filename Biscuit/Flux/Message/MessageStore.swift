//
//  MessageStore.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 03..
//

import Foundation

class MessageStore: Store {
    @Published var state: MessagesState

    init() {
        self.state = MessagesState.init(messages: [])
    }

    func reducer(action: MessageActions) {
        switch action {
        case .didReceivedMessage(let message):
            handleDidReceivedMessage(newMessage: message)
        }
    }
}

private extension MessageStore {
    func handleDidReceivedMessage(newMessage: Message) {
        modify { state in
            let existing = state.messages.first(where: { (message: Message) in
                message.bagelPacketId == newMessage.bagelPacketId
            })

            if let existing = existing, let i = state.messages.firstIndex(of: existing) {
                state.messages[i] = newMessage
            } else {
                state.messages.append(newMessage)
            }
        }
    }

    func modify(_ transform: (inout MessagesState) -> Void) {
        var copy = state
        transform(&copy)
        state = copy
    }
}

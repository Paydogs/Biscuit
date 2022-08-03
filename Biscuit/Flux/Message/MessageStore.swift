//
//  MessageStore.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 03..
//

import Factory

extension Container {
    static let messageStore = Factory { MessageStore(state: MessagesState.initialValue()) }
}

class MessageStore: BaseStore<MessagesState> {
    override func reduce(action: Action) {
        guard let action = action as? MessageActions else { return }

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
}

//
//  MessageStore.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 06..
//

import Foundation

class MessageStore: BaseStore<MessageState> {
    override func handleAction(action: Action) {
        guard let action = action as? MessageActions else { return }
        print("MessageStore is handling action")
        switch action {
            case .didReceivedMessage(let message):
                handleDidReceivedMessage(message: message)
        }
    }
}

private extension MessageStore {
    func handleDidReceivedMessage(message: Message) {
        update { state in
            let existingIndex = state.messages.firstIndex { storedMessage in
                storedMessage.bagelPacketId == message.bagelPacketId
            }
            if let index = existingIndex {
                print("message found at \(index), replacing")
                state.messages.remove(at: index)
                state.messages.insert(message, at: index)
            } else {
                print("message not found, appending")
                state.messages.append(message)
            }
        }
    }
}

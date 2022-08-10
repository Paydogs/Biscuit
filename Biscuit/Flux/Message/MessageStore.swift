//
//  MessageStore.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 06..
//

import Foundation

class MessageStore: Store {
    typealias TransformState = (inout MessageState) -> Void
    @Published var state: MessageState

    init() {
        state = MessageState.defaultValue()
    }

    func handleAction(action: Action) {
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

private extension MessageStore {
    func update(_ transform: TransformState) {
        var copy = state
        transform(&copy)
        state = copy
    }
}

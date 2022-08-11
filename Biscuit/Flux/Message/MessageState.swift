//
//  MessageState.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 06..
//

struct MessageState: State {
    var messages: [Message]
}

extension MessageState: DefaultInitializer {
    static func defaultValue() -> MessageState {
        return .init(messages: [])
    }
}

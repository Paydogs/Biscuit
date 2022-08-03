//
//  MessagesState.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 26..
//

import Foundation

struct MessagesState: State {
    var messages: [Message]
}

extension MessagesState {
    static func initialValue() -> MessagesState {
        return .init(messages: [])
    }
}

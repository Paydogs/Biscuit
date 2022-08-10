//
//  Showcase.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 10..
//

import Foundation
import Combine
import Factory

class Showcase {
    @Injected(BiscuitContainer.messageStore) private var messageStore
    var subscription: AnyCancellable?

    func startPeaking() {
        subscribeMessages()
    }

    func subscribeMessages() {
        subscription = messageStore.$state.sink { (value: MessageState) in
            for message in value.messages {
                message.quickDescription()
            }
        }
    }
}

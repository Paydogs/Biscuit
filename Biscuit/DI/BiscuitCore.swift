//
//  BiscuitCore.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 09..
//

import Foundation
import Factory

struct BiscuitCore {
    @Injected(BiscuitContainer.dispatcher) private var dispatcher

    static func startup() {
        registerStores()
    }
}

private extension BiscuitCore {
    static func registerStores() {
        let dispatcher = BiscuitContainer.dispatcher.resolve()
        dispatcher.registerStore(store: BiscuitContainer.messageStore.resolve())
    }
}

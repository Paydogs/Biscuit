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

    private let peaker: Peaker

    init() {
        print("[BiscuitCore] init")
        self.peaker = Peaker()
    }

    func startup() {
        print("[BiscuitCore] startup")
        registerStores()
        peaker.startPeaking()
    }
}

private extension BiscuitCore {
    func registerStores() {
        print("[BiscuitCore] Registering stores...")
        let dispatcher = BiscuitContainer.dispatcher.resolve()
        dispatcher.registerStore(store: BiscuitContainer.appStore.resolve())
        dispatcher.registerStore(store: BiscuitContainer.packetStore.resolve())
    }
}

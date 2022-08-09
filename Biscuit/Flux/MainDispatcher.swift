//
//  MainDispatcher.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 06..
//

public class MainDispatcher: Dispatcher {
    private var stores: [Store] = []

    func registerStore(store: Store) {
        print("[MainDispatcher] registering a store: \(store)")
        stores.append(store)
        print("[MainDispatcher] now have \(stores.count)")
    }

    func dispatch(action: Action) {
        print("[MainDispatcher] dispatching action to \(stores.count) stores")
        for store in stores {
            store.handleAction(action: action)
        }
    }
}

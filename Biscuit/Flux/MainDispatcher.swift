//
//  MainDispatcher.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 06..
//

import Foundation

public class MainDispatcher: FluxDispatcher {
    private var stores: [FluxStore] = []
    var queue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.magnificat.Biscuit.dispatcherQueue"
        return queue
    }()

    func registerStore(store: FluxStore) {
        print("[MainDispatcher] registering a store: \(store)")
        stores.append(store)
        print("[MainDispatcher] now have \(stores.count)")
    }

    func dispatch(action: FluxAction) {
        print("[MainDispatcher] dispatching action to \(stores.count) stores")
        let operations = stores.map { store in
            BlockOperation {
                OperationQueue.main.addOperation {
                    store.handleAction(action: action)
                }
            }
        }
        queue.addOperations(operations, waitUntilFinished: true)
    }
}

//
//  MainDispatcher.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 06..
//

import Foundation

public class MainDispatcher: Dispatcher {
    private var stores: [Store] = []
    var queue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.magnificat.Biscuit.dispatcherQueue"
        return queue
    }()

    func registerStore(store: Store) {
        print("[MainDispatcher] registering a store: \(store)")
        stores.append(store)
        print("[MainDispatcher] now have \(stores.count)")
    }

    func dispatch(action: Action) {
        print("[MainDispatcher] dispatching action to \(stores.count) stores")
        let operations = stores.map { store in
            BlockOperation {
                store.handleAction(action: action)
                OperationQueue.main.addOperation {
                }
            }
        }
        queue.addOperations(operations, waitUntilFinished: true)
    }
}

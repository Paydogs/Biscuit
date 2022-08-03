//
//  DefaultDispatcher.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 03..
//

import Factory
import Foundation

extension Container {
    static let dispatcher = Factory { DefaultDispatcher() as Dispatcher }
}

class DefaultDispatcher: Dispatcher {
    private lazy var operationQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "queue"
        queue.qualityOfService = .userInteractive
        return queue
    }()

    @Injected(Container.messageStore) private var messageStore

    func dispatch(action: Action) {
        print("Dispatching action: \(action)")
    }
}

//
//  BaseStore.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 12..
//

import Foundation

class BaseStore<T: State>: Store {
    typealias BoundedContext = T
    typealias TransformState = (inout T) -> Void

    @Published var state: T
    @Published var mainState: StateWrapper<T>

    init(state: T) {
        self.state = state
        self.mainState = StateWrapper<T>(state: state)
    }

    func handleAction(action: Action) {
        /* no-op */
    }
}

extension BaseStore {
    func update(_ transform: TransformState) {
        var copy = state
        transform(&copy)
        state = copy
    }
}

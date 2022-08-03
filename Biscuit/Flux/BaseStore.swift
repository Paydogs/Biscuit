//
//  BaseStore.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 03..
//

import Foundation

class BaseStore<T: State>: Store {
    typealias IncludedState = T

    @Published var state: T

    init(state: T) {
        self.state = state
    }

    func reduce(action: Action) {
        fatalError("Override needed")
    }

    func modify(_ transform: (inout T) -> Void) {
        var copy = state
        transform(&copy)
        state = copy
    }
}

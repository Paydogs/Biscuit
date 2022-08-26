//
//  BaseStore.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 12..
//

import Foundation

class BaseStore<T: FluxState>: FluxStore {
    typealias BoundedContext = T
    typealias TransformState = (inout T) -> Void

    private var _state: T
    let observed: Observed<T>

    init(state: T) {
        _state = state
        self.observed = Observed<T>(state: state)
    }

    func handleAction(action: FluxAction) {
        /* no-op */
    }
}

extension BaseStore {
    func update(_ transform: TransformState) {
        var copy = _state
        transform(&copy)
        _state = copy
        observed.state = copy
    }
}

class Observed<T: FluxState>: ObservableObject {
    @Published fileprivate(set) var state: T

    init(state: T) {
        self.state = state
    }
}

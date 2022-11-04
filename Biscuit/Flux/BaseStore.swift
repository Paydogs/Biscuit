//
//  BaseStore.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 12..
//

import Foundation

class BaseStore<State: FluxState>: FluxStore {
    typealias TransformState = (inout State) -> Void

    private var _state: State
    let observed: Observed<State>

    init(state: State) {
        _state = state
        self.observed = Observed<State>(state: state)
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

class Observed<State: FluxState>: ObservableObject {
    @Published fileprivate(set) var state: State

    init(state: State) {
        self.state = state
    }
}

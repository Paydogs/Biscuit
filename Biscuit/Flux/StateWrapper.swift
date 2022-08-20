//
//  StateWrapper.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 14..
//

import Combine

class StateWrapper<T: State>: ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    var state: T { didSet {
        print("StateWrapper didChanged")
        didChange.send() }}

    init(state: T) {
        self.state = state
    }
}

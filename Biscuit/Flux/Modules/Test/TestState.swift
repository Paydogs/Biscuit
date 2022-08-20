//
//  TestState.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 13..
//

struct TestState: State {
    var currentValue: Int
}

extension TestState: DefaultInitializer {
    static func defaultValue() -> TestState {
        return .init(currentValue: 0)
    }
}

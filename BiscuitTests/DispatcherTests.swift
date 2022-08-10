//
//  DispatcherTests.swift
//  BiscuitTests
//
//  Created by Andras Olah on 2022. 08. 09..
//

import XCTest
import SwiftyMocky

@testable import Biscuit

class DispatcherTests: XCTestCase {
    var testDispatcher: MainDispatcher!
    var storeMock: StoreMock!

    override func setUp() {
        testDispatcher = MainDispatcher()
        storeMock = StoreMock()
        testDispatcher.registerStore(store: storeMock)
    }

    override func tearDown() {
        testDispatcher = nil
        storeMock = nil
    }

    func testSimpleDispatch() {
        // Given
        let givenAction = TestAction.Tick
//        Matcher.default.register(Action.Type.self) { (lhs, rhs) -> Bool in
//            return lhs == rhs
//        }

        // When
        testDispatcher.dispatch(action: givenAction)

        // Then
        Verify(storeMock, .handleAction(action: .any))
    }
}

private extension DispatcherTests {
    enum TestAction: Action, Comparable {
        case Tick
        case Tock
    }
}

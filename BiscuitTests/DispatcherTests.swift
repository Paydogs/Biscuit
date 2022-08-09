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
    let mock = MainDispatcher()
    let storeMock = StoreMock()

    func testDispatch() {
        let test = mock.registerStore(store: storeMock)
        
    }
}

//
//  LogContainer.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 22..
//

import Combine
import SwiftUI

struct LogContainer: View {
    @ObservedObject var state: Observed<TestState>

    var body: some View {
        Text("Test: \(state.state.currentValue)")
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}

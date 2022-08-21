//
//  SampleButton.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 22..
//

import SwiftUI
import Factory

struct SampleButton: View {
    typealias Action = ()->()
    var action: Action
//    @Injected(BiscuitContainer.changeValueUseCase) private var useCase
//    @Injected(BiscuitContainer.dispatcher) private var dispatcher

    var body: some View {
        Button("Test button") { action() }
//            print("Test button pressed")
//            useCase.execute(amount: Int.random(in: -5...5))
//        }
    }
}

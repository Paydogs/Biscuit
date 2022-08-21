//
//  MainWindow.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 23..
//

import SwiftUI
import Factory
import Combine

struct MainWindow: View {
    @ObservedObject var state: Observed<TestState>
    @Injected(BiscuitContainer.changeValueUseCase) private var changeValueUseCase
    @Injected(BiscuitContainer.dispatcher) private var dispatcher

    var body: some View {
        HStack {
            HStack {
                ProcessContainer()
                    .background(Colors.Background.panelBackground)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
            VStack {
                SampleButton { changeValueUseCase.execute(amount: Int.random(in: -5...5)) }
                LogContainer(state: state)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
        }
        .frame(minWidth: 640, minHeight: 480)
    }
}

struct MainWindow_Previews: PreviewProvider {
    static var previews: some View {
        MainWindow(state: Observed<TestState>(state: TestState.defaultValue()))
    }
}

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
    @Injected(BiscuitContainer.testStore) private var testStore

    var body: some View {
        HStack {
            HStack {
                ProcessContainer()
                    .background(Colors.Background.panelBackground)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
            VStack {
                SampleButton()
                LogContainer(state: testStore.mainState)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
        }
        .frame(minWidth: 640, minHeight: 480)
    }
}

struct SampleButton: View {
    @Injected(BiscuitContainer.changeValueUseCase) private var useCase
    @Injected(BiscuitContainer.dispatcher) private var dispatcher

    var body: some View {
        Button("Test button") {
            print("Test button pressed")
            useCase.execute(amount: Int.random(in: -5...5))
        }
    }
}

struct ProcessContainer: View {
    var body: some View {
        Text("Process Container")
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}

struct LogContainer: View {
    @ObservedObject var state: StateWrapper<TestState>

    var body: some View {
        Text("Test: \(state.state.currentValue)")
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}

struct MainWindow_Previews: PreviewProvider {
    static var previews: some View {
        MainWindow()
    }
}

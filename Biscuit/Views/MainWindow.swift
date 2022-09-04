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
    @EnvironmentObject var state: MainWindowState

    var body: some View {
        VStack {
            HeaderComponent()
            HStack {
                VStack {
                    LogContainer(data: state.logContainerData)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
            }
            .frame(minWidth: 640, minHeight: 480)
        }
    }
}

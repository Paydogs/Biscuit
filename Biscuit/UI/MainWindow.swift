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
    @EnvironmentObject var appController: AppController
    @Injected(BiscuitContainer.headerAreaController) var headerAreaController
    @Injected(BiscuitContainer.logAreaController) var logAreaController

    var body: some View {
        VStack {
            HeaderArea(domain: headerAreaController.domain,
                       eventHandler: headerAreaController.eventHandler)
            HStack {
                VStack {
                    LogArea(domain: logAreaController.domain,
                            eventHandler: logAreaController.eventHandler)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
            }
            .frame(minWidth: 640, minHeight: 480)
        }
    }
}

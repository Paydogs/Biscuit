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
    @Injected(BiscuitContainer.headerViewController) var headerViewController
    @Injected(BiscuitContainer.logViewController) var logViewController

    var body: some View {
        VStack {
            HeaderView(domain: headerViewController.domain,
                       eventHandler: headerViewController.eventHandler)
            HStack {
                VStack {
                    LogView(domain: logViewController.domain,
                            eventHandler: logViewController.eventHandler)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
            }
            .frame(minWidth: 640, minHeight: 480)
        }
    }
}

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
    @Injected(BiscuitContainer.packetViewController) var packetViewController

    var body: some View {
        HSplitView {
            VStack {
                HeaderView(domain: headerViewController.domain,
                           eventHandler: headerViewController.eventHandler)
                .background(BlurView(material: .headerView))
                    VStack {
                        LogView(domain: logViewController.domain,
                                eventHandler: logViewController.eventHandler)
                    }
                    .layoutPriority(1)
                }
            PacketView(domain: packetViewController.dataProvider.domain,
                       eventHandler: packetViewController.eventHandler)
            .background(BlurView(material: .sidebar))
        }
        .frame(minWidth: 800, minHeight: 480)
    }
}

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
    private let headerViewDomain: HeaderViewDomain
    private let headerViewEventHandler: HeaderViewEventHandling
    private let logViewDomain: LogViewDomain
    private let logViewEventHandler: LogViewEventHandling
    private let packetViewDomain: PacketViewDomain
    private let packetViewEventHandler: PacketViewEventHandling

    init(headerViewDomain: HeaderViewDomain,
         headerViewEventHandler: HeaderViewEventHandling,
         logViewDomain: LogViewDomain,
         logViewEventHandler: LogViewEventHandling,
         packetViewDomain: PacketViewDomain,
         packetViewEventHandler: PacketViewEventHandling) {
        self.headerViewDomain = headerViewDomain
        self.headerViewEventHandler = headerViewEventHandler
        self.logViewDomain = logViewDomain
        self.logViewEventHandler = logViewEventHandler
        self.packetViewDomain = packetViewDomain
        self.packetViewEventHandler = packetViewEventHandler
    }

    var body: some View {
        HSplitView {
            VStack {
                HeaderView(domain: headerViewDomain, eventHandler: headerViewEventHandler)
                    .background(BlurView(material: .titlebar))
                VStack {
                    LogView(domain: logViewDomain, eventHandler: logViewEventHandler)
                }
                .layoutPriority(1)
            }
            PacketView(domain: packetViewDomain, eventHandler: packetViewEventHandler)
                .background(BlurView(material: .underPageBackground))
        }
        .frame(minWidth: 800, minHeight: 480)
    }
}

struct MainWindow_Previews: PreviewProvider {
    static var previews: some View {
        MainWindow(headerViewDomain: HeaderViewMockFactory.createDummyDomain(),
                   headerViewEventHandler: HeaderViewMockFactory.createDummyHandler(),
                   logViewDomain: LogViewMockFactory.createDummyDomain(),
                   logViewEventHandler: LogViewMockFactory.createDummyHandler(),
                   packetViewDomain: PacketViewMockFactory.createDummyDomain(),
                   packetViewEventHandler: PacketViewMockFactory.createDummyHandler())
    }
}

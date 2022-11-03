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
    private let controller: MainWindowController

    init(controller: MainWindowController) {
        self.controller = controller
    }

    var body: some View {
        HSplitView {
            VStack {
                HeaderView(controller: controller.headerViewController)
                    .background(BlurView(material: .titlebar))
                VStack {
                    LogView(controller: controller.logViewController)
                }
                .layoutPriority(1)
            }
            PacketView(controller: controller.packetViewController)
                .background(BlurView(material: .underPageBackground))
        }
        .frame(minWidth: 800, minHeight: 480)
    }
}

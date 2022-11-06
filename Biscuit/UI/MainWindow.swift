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
    var body: some View {
        HSplitView {
            VStack {
                HeaderView()
                    .background(BlurView(material: .titlebar))
                VStack {
                    LogView()
                }
                .layoutPriority(1)
            }
            PacketView()
                .background(BlurView(material: .underPageBackground))
        }
        .frame(minWidth: 800, minHeight: 480)
    }
}

struct MainWindow_Previews: PreviewProvider {
    static var previews: some View {
        MainWindow()
    }
}

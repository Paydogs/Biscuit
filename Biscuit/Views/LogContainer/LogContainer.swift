//
//  LogContainer.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 22..
//

import Combine
import SwiftUI
import Factory

struct LogContainer: View {
    @Injected(BiscuitContainer.logController) var controller

    var body: some View {
        Table(controller.packets) {
            TableColumn("Status", value: \.status)
                .width(max: 50)
            TableColumn("Method", value: \.method)
                .width(max: 50)
            TableColumn("Url", value: \.url)
            TableColumn("Date", value: \.date)
        }
    }
}

//
//  LogArea.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 22..
//

import Combine
import SwiftUI
import Factory

struct LogArea: View {
    @ObservedObject var domain: LogAreaDomain
    var eventHandler: LogAreaEventHandling

    var body: some View {
        Table(domain.packets) {
            TableColumn("Status", value: \.status)
                .width(max: 50)
            TableColumn("Method", value: \.method)
                .width(max: 50)
            TableColumn("Url", value: \.url)
            TableColumn("Date", value: \.date)
        }
    }
}

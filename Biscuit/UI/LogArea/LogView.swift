//
//  LogView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 22..
//

import Combine
import SwiftUI
import Factory

struct LogView: View {
    @ObservedObject var domain: LogViewDomain
    var eventHandler: LogViewEventHandling

    var body: some View {
        Table(domain.packets) {
            TableColumn("Status") { item in
                Text(item.status)
                    .foregroundColor(item.statusColor)
            }
            .width(min: 40, max: 50)
            TableColumn("Method") { item in
                Text(item.method)
                    .foregroundColor(item.methodColor)
            }
            .width(min: 40, max: 50)
            TableColumn("Url", value: \.url)
            TableColumn("Date", value: \.date)
        }
    }
}

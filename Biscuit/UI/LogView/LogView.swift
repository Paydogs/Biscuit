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
    @State private var selectedPacket = Set<PacketTableRow.ID>()

    var body: some View {
        Table(domain.packets, selection: $selectedPacket) {
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
        .onChange(of: selectedPacket) { selected in
            eventHandler.selectPackets(identifiers: Array(selected))
        }
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView(domain: createDummyDomain(),
                eventHandler: DummyHandler())
    }
}

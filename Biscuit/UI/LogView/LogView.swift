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
            TableColumn(Localizable.LogView.TableColumn.status) { item in
                Text(item.status)
                    .foregroundColor(item.statusColor)
            }
            .width(min: 45, max: 45)
            TableColumn(Localizable.LogView.TableColumn.method) { item in
                Text(item.method)
                    .foregroundColor(item.methodColor)
            }
            .width(min: 45, max: 45)
            TableColumn(Localizable.LogView.TableColumn.url, value: \.url)
            TableColumn(Localizable.LogView.TableColumn.date, value: \.date)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
        .contextMenu {
            Button(Localizable.LogView.ContextMenu.export, action: {
                eventHandler.exportPackets()
            })
            .disabled(selectedPacket.isEmpty)
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

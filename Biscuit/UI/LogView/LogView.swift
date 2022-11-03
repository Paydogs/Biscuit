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
    @StateObject private var domain: LogViewDomain
    private var eventHandler: LogViewEventHandling

    init(controller: LogViewController) {
        _domain = StateObject(wrappedValue: controller.domain)
        eventHandler = controller
    }

    @State private var selectedPacket = Set<PacketTableRow.ID>()

    var body: some View {
        Table(domain.packets, selection: $selectedPacket) {
            TableColumn(Localized.LogView.TableColumn.status) { item in
                Text(item.status)
                    .foregroundColor(item.statusColor)
            }
            .width(min: 45, max: 45)
            TableColumn(Localized.LogView.TableColumn.method) { item in
                Text(item.method)
                    .foregroundColor(item.methodColor)
            }
            .width(min: 45, max: 45)
            TableColumn(Localized.LogView.TableColumn.url, value: \.url)
            TableColumn(Localized.LogView.TableColumn.date, value: \.date)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
        .contextMenu {
            Button(Localized.LogView.ContextMenu.export, action: {
                eventHandler.exportPackets()
            })
            .disabled(selectedPacket.isEmpty)
        }
        .onChange(of: selectedPacket) { selected in
            eventHandler.selectPackets(identifiers: Array(selected))
        }
    }
}

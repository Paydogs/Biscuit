//
//  LogView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 22..
//

import Combine
import SwiftUI
import Factory

struct LogView<ViewModel: LogViewViewModelInterface>: View {
    @StateObject var viewModel: ViewModel
    @State private var selectedPacket = Set<PacketTableRow.ID>()

    init(viewModel: ViewModel = LogViewViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Table(viewModel.packets, selection: $selectedPacket) {
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
                viewModel.exportPackets()
            })
            .disabled(selectedPacket.isEmpty)
        }
        .onChange(of: selectedPacket) { selected in
            viewModel.selectPackets(identifiers: Array(selected))
        }
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView(viewModel: MockLogViewViewModel())
    }
}

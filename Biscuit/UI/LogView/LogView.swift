//
//  LogView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 22..
//

import Combine
import SwiftUI
import Factory

struct LogView<ViewModel: LogViewModelInterface>: View {
    @StateObject var viewModel: ViewModel
    @State private var selectedPacket = Set<PacketTableRow.ID>()
    @State private var filterUrl: String = ""
    @State var urlFilterDisabled: Bool = true // Bug workaround

    init(viewModel: ViewModel = LogViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 0) {
            Table(viewModel.packets, selection: $selectedPacket) {
                TableColumn("") { item in
                    Button {
                        viewModel.pinPackets(identifiers: [item.id])
                    } label: {
                        Image(systemName: item.pinned ? IconName.pinOn : IconName.pinOff)
                            .foregroundColor(item.pinned ? Colors.Defaults.red : Colors.Text.primaryText)
                            .opacity(item.pinned ? 1 : 0.2)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                .width(min: 15, max: 15)
                TableColumn(Localized.LogView.TableColumn.status) { item in
                    Text(item.status)
                        .foregroundColor(item.statusColor)
                }
                .width(min: 45, max: 45)
                TableColumn(Localized.LogView.TableColumn.method) { item in
                    Text(item.method)
                        .foregroundColor(item.methodColor)
                }
                .width(min: 55, max: 55)
                TableColumn(Localized.LogView.TableColumn.url, value: \.url)
                TableColumn(Localized.LogView.TableColumn.date, value: \.date)
            }
            Divider()
            HStack {
                Text(Localized.LogView.filterTitle)
                    .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 5))

                TextField(Localized.LogView.filterPlaceholder, text: $filterUrl)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.init(top: 5, leading: 0, bottom: 5, trailing: 10))
                    .disabled(urlFilterDisabled)
                    .onAppear {
                        DispatchQueue.main.async { urlFilterDisabled = false }
                     }
                Spacer()
                HStack {
                    SmallActionButton(data: SmallActionButton.Data(icon: IconName.hide, help: Localized.LogView.hideMessagesButtonHelp),
                                      event: SmallActionButton.Event(action: { viewModel.hideCurrentMessages() }))
                    .disabled(viewModel.packets.isEmpty)
                    .contextMenu {
                        Button {
                            viewModel.resetMessageHiding()
                        } label: {
                            Label(Localized.LogView.hideMessagesButtonContextReset, systemImage: IconName.undo)
                                .labelStyle(.titleAndIcon)
                        }
                    }

                    SmallActionButton(data: SmallActionButton.Data(icon: IconName.undo, help: Localized.LogView.hideMessagesButtonContextReset),
                                      event: SmallActionButton.Event(action: { viewModel.resetMessageHiding() }))
                    .disabled(!viewModel.hasTimeFilter)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
            }
            .frame(height: 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
        .contextMenu {
            Button {
                viewModel.pinPackets(identifiers: Array(selectedPacket))
            } label: {
                Label(Localized.LogView.ContextMenu.pinSelected, systemImage: IconName.pinOn).labelStyle(.titleAndIcon)
            }
            .disabled(selectedPacket.isEmpty)
            Button {
                viewModel.unpinPackets(identifiers: Array(selectedPacket))
            } label: {
                Label(Localized.LogView.ContextMenu.unpinSelected, systemImage: IconName.pinOff).labelStyle(.titleAndIcon)
            }
            .disabled(selectedPacket.isEmpty)
            Divider()
            Button {
                viewModel.clearFromLastSelected()
            } label: {
                Label(Localized.LogView.ContextMenu.clearFromHere, systemImage: IconName.hide).labelStyle(.titleAndIcon)
            }
            .disabled(selectedPacket.isEmpty)
            Divider()
            Button {
                viewModel.exportPackets()
            } label: {
                Label(Localized.LogView.ContextMenu.exportSelectedBody, systemImage: IconName.export).labelStyle(.titleAndIcon)
            }
            .disabled(selectedPacket.isEmpty)
        }
        .onChange(of: selectedPacket) { selected in
            viewModel.selectPackets(identifiers: Array(selected))
        }
        .onChange(of: filterUrl) { url in
            viewModel.filterUrl(url: url)
        }
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView(viewModel: MockLogViewModel())
            .darkPreview(title: "Dark")
        LogView(viewModel: MockLogViewModel())
            .lightPreview(title: "Light")
    }
}

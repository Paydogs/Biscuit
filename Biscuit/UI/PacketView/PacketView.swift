//
//  PacketView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 28..
//

import Combine
import SwiftUI
import Factory
import Highlight

struct PacketView<ViewModel: PacketViewViewModelInterface>: View {
    @StateObject var viewModel: ViewModel
    @State private var selectedTab: Tab = .overview

    init(viewModel: ViewModel = PacketViewViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

//    let tabs: [Tab] = [.overview, .response, .request]

    var body: some View {
        VStack {
            Picker("", selection: $selectedTab) {
                ForEach(tabs, id:\.self) { tab in
                    switch tab {
                        case .overview: Text(Localized.PacketView.Tab.overview)
                        case .request: Text(Localized.PacketView.Tab.request)
                        case .response: Text(Localized.PacketView.Tab.response)
                    }
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .padding(EdgeInsets(top: 10, leading: 25, bottom: 1, trailing: 25))

            ZStack {
                switch selectedTab {
                    case .overview: Overview(packetBody: packetBody)
                    case .request: RequestView()
                    case .response: ResponseView()
                }
            }

            HStack {
                SmallActionButton(data: copyBodyToClipboardButtonData,
                                  event: .init(action: {  viewModel.copyBodyToClipboard(packet: viewModel.selectedPacket) }))
                Spacer()
                .frame(alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
    }
}

extension PacketView {
    enum Tab: String {
        case overview
        case request
        case response
    }
}

private extension PacketView {
    var tabs: [Tab] {
        [.overview, .response, .request]
    }
    var packetBody: NSAttributedString {
        return viewModel.selectedPacket?.colorizedOverviewDescription ?? Localized.packetNothingToShow.withStyle(Style(color: Colors.JSON.unknownColor))
    }

    var copyBodyToClipboardButtonData: SmallActionButton.Data {
        return SmallActionButton.Data(icon: "doc.on.clipboard.fill",
                                      help: Localized.PacketView.Button.copyToPasteboard)
    }
}

struct PacketView_Previews: PreviewProvider {
    static var previews: some View {
        PacketView(viewModel: MockPacketViewViewModel())
    }
}

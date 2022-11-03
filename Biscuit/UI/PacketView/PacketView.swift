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

struct PacketView: View {
    @StateObject var domain: PacketViewDomain
    private let eventHandler: PacketViewEventHandling

    init(controller: PacketViewController) {
        eventHandler = controller
        _domain = StateObject(wrappedValue: controller.domain)
    }

    @State private var selectedTab: Tab = .overview
    private let tabs: [Tab] = [.overview, .response, .request]

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
                                  event: .init(action: {  eventHandler.copyBodyToClipboard(packet: domain.selectedPacket) }))
                Spacer()
                    .frame(alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
    }
}

private extension PacketView {
    enum Tab: String {
        case overview
        case request
        case response
    }
}

private extension PacketView {
    var packetBody: NSAttributedString {
        return domain.selectedPacket?.colorizedOverviewDescription ?? Localized.packetNothingToShow.withStyle(Style(color: Colors.JSON.unknownColor))
    }

    var copyBodyToClipboardButtonData: SmallActionButton.Data {
        SmallActionButton.Data(icon: "doc.on.clipboard.fill",
                               help: Localized.PacketView.Button.copyToPasteboard)
    }
}

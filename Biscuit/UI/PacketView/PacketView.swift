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
    @ObservedObject var domain: PacketViewDomain
    var eventHandler: PacketViewEventHandling
    @State private var selectedTab: Tab = .overview

    var body: some View {
        let body: NSAttributedString = domain.selectedPacket?.colorizedOverviewDescription ??
        Localizable.packetNothingToShow.withStyle(Style(color: Colors.JSON.unknownColor))

        VStack {
            Picker("", selection: $selectedTab) {
                ForEach(tabs, id:\.self) { tab in
                    Text(tab.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .padding(EdgeInsets(top: 10, leading: 25, bottom: 1, trailing: 25))

            ZStack {
                switch selectedTab {
                    case .overview: Overview(packetBody: body)
                    case .request: RequestView()
                    case .response: ResponseView()
                }
            }

            HStack {
                SmallActionButton(data: copyBodyToClipboardButtonData,
                                  event: SmallActionButton.Event(action: { eventHandler.copyBodyToClipboard(packet: domain.selectedPacket) }))
                Spacer()
                .frame(alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
    }
}

extension PacketView {
    enum Tab: String {
        case overview = "Overview"
        case request = "Request"
        case response = "Response"
    }

    var tabs: [Tab] {
        [.overview, .response, .request]
    }

    var copyBodyToClipboardButtonData: SmallActionButton.Data {
        SmallActionButton.Data(icon: "doc.on.clipboard.fill",
                               help: "Copy body to Clipboard")
    }
}

struct PacketView_Previews: PreviewProvider {
    static var previews: some View {
        PacketView(domain: createDummyDomain(),
                   eventHandler: DummyHandler())
    }
}

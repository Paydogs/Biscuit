//
//  PacketView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 28..
//

import Combine
import SwiftUI
import Factory

struct PacketView: View {
    @ObservedObject var domain: PacketViewDomain
    var eventHandler: PacketViewEventHandling
    let tabs: [Tab] = [.overview, .request, .response]

    @State private var selectedTab: Tab = .overview
    var body: some View {
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
                    case .overview: Overview()
                    case .request: RequestView()
                    case .response: ResponseView()
                }
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
}

struct PacketView_Previews: PreviewProvider {
    static var previews: some View {
        PacketView(domain: createDummyDomain(),
                   eventHandler: DummyHandler())
    }
}

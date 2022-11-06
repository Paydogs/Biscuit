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
            .padding(EdgeInsets(top: 10, leading: 5, bottom: 1, trailing: 5))

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
        case overview
        case request
        case response
    }
}

private extension PacketView {
    var tabs: [Tab] {
        [.overview, .response, .request]
    }
}

struct PacketView_Previews: PreviewProvider {
    static var previews: some View {
        PacketView(viewModel: MockPacketViewViewModel())
    }
}

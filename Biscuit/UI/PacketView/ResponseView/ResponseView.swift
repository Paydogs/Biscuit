//
//  ResponseView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 02..
//

import Combine
import SwiftUI
import Factory
import Highlight

struct ResponseView: View {
    @State private var selectedTab: Tab = .body

    var body: some View {
        VStack {
            Picker("", selection: $selectedTab) {
                ForEach(tabs, id:\.self) { tab in
                    switch tab {
                        case .body: Text(Localized.ResponseView.Tab.body)
                        case .headers: Text(Localized.ResponseView.Tab.headers)
                    }
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5))
            .frame(height: 25, alignment: .top)
            Spacer()
            ZStack {
                switch selectedTab {
                    case .body: ResponseBodyView()
                    case .headers: ResponseHeadersView()
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

extension ResponseView {
    enum Tab: String {
        case body
        case headers
    }
}

private extension ResponseView {
    var tabs: [Tab] {
        [.body, .headers]
    }
}

struct ResponseView_Previews: PreviewProvider {
    static var previews: some View {
        ResponseView()
            .darkPreview(title: "Dark")
        ResponseView()
            .lightPreview(title: "Light")
    }
}

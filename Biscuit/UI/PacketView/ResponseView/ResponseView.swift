//
//  ResponseView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 02..
//

import SwiftUI

struct ResponseView: View {
    let tabs: [Tab] = [.body, .headers]

    @State private var selectedTab: Tab = .body

    var body: some View {
        VStack {
            Picker("", selection: $selectedTab) {
                ForEach(tabs, id:\.self) { tab in
                    switch tab {
                        case .body: Text(Localizable.ResponseView.Tab.body)
                        case .headers: Text(Localizable.ResponseView.Tab.headers)
                    }
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5))
            .frame(height: 25, alignment: .top)
            Spacer()
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

struct ResponseView_Previews: PreviewProvider {
    static var previews: some View {
        ResponseView()
    }
}

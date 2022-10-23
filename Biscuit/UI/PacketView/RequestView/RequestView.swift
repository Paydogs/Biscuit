//
//  RequestView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 02..
//

import SwiftUI

struct RequestView: View {
    let tabs: [Tab] = [.body, .headers, .parameters]
    
    @State private var selectedTab: Tab = .body

    var body: some View {
        VStack {
            Picker("", selection: $selectedTab) {
                ForEach(tabs, id:\.self) { tab in
                    switch tab {
                        case .body: Text(Localizable.RequestView.Tab.body)
                        case .headers: Text(Localizable.RequestView.Tab.headers)
                        case .parameters: Text(Localizable.RequestView.Tab.parameters)
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

extension RequestView {
    enum Tab: String {
        case body
        case headers
        case parameters
    }
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestView()
    }
}

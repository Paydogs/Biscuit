//
//  RequestView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 02..
//

import SwiftUI

struct RequestView<ViewModel: RequestViewModelInterface>: View {
    @StateObject var viewModel: ViewModel
    @State private var selectedTab: Tab = .body

    init(viewModel: ViewModel = RequestViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            Picker("", selection: $selectedTab) {
                ForEach(tabs, id:\.self) { tab in
                    switch tab {
                        case .body: Text(Localized.RequestView.Tab.body)
                        case .headers: Text(Localized.RequestView.Tab.headers)
                        case .parameters: Text(Localized.RequestView.Tab.parameters)
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


private extension RequestView {
    var tabs: [Tab] {
        [.body, .headers, .parameters]
    }
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestView(viewModel: MockRequestViewModel())
            .darkPreview(title: "Dark")
        RequestView(viewModel: MockRequestViewModel())
            .lightPreview(title: "Light")
    }
}

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

struct ResponseView<ViewModel: ResponseViewModelInterface>: View {
    @StateObject var viewModel: ViewModel

    init(viewModel: ViewModel = ResponseViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            VStack() {
                ResponseHeadersView(responseHeaders: viewModel.responseHeaders)
                ResponseBodyView(attributedText: viewModel.responseBody)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
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
